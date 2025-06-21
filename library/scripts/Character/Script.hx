// API Script


var neutralSpecialProjectile = self.makeObject(null); // Tracks active Neutral Special projectile (in case we need to handle any special cases)

var lastDisabledNSpecStatusEffect = self.makeObject(null);

var downSpecialLoopCheckTimer = self.makeInt(-1);

var clutchButtonHeld = self.makeBool(false); // Check if the clutch button is held current frame
var clutchButtonWasHeld = self.makeBool(false); // Check if the clutch button was held prev. frame

//offset projectile start position
var NSPEC_PROJ_X_OFFSET = 40;
var NSPEC_PROJ_Y_OFFSET = -50;

var NEUTRAL_SPECIAL_COOLDOWN = 60;

var UP_SPECIAL_SPEED_X = 5.25;
var UP_SPECIAL_SPEED_Y = -20;
var UP_SPECIAL_COOLDOWN_TIME = 60;
var UP_SPECIAL_HITBOXSTATS = { damage: 8, angle: 270, knockbackGrowth: 5, baseKnockback: 45, hitstop: -1, selfHitstop: -1, hitstopOffset:2, selfHitstopOffset:2, limb:AttackLimb.BODY, tumbleType: TumbleType.ALWAYS, owner:self };

var WAVEDASH_TEXT_COUNT = 4;
var CLUTCH_STATES = [
    CState.SPECIAL_UP,
    CState.SPECIAL_SIDE
];
function canClutch() : Bool {
    for (i in 0...CLUTCH_STATES.length) {
        if (self.getState() == CLUTCH_STATES[i]) {
            return true;
        }
    }
    return false;
}
var clutchAvaliable = self.makeBool(false);

var upSpecIgnoreList = self.makeArray(new Array());

var heldTransformationData = self.makeObject(null);
var heldTransformationObject = self.makeObject(null);
var heldTransformationHudSprite = self.makeObject(null);
var heldTransformationFilter = self.makeObject(null);
var TRANSFORMATION_FLASH_RATE = 12;
var TRANSFORMATION_BRIGHTNESS = 0.25;
var TRANSFORMATION_BASE_CAST_DATA:StringMap = [
    "public::commandervideo.commandervideo" => {
        spriteContent: self.getResource().getContent("framy"),
        introAnimation: "transformation_commandervideo_intro",
        abilityName: "CommanderVideo",
        abilityGameObjectId: self.getResource().getContent("transformationCommandervideoObject"),
        abilityCanClutch: true,
        transformVfxColorMap: [
            // TOP LEFT
            0xff679464 => 0xff4a4a4a,
            0xff40663d => 0xff323232,
            0xff274425 => 0xff242424,
            // TOP RIGHT
            0xff72823f => 0xffffa632,
            0xffa9bc71 => 0xffb66a07,
            // BOTTOM LEFT
            0xff608688 => 0xff36a6aa,
            0xff416063 => 0xff197275,
            0xff22393c => 0xff0d4b4d,
            // BOTTOM RIGHT
            0xff6e77a6 => 0xffdc6ca7, 
            0xff49517f => 0xffa6497a, 
            0xff33395d => 0xff71254d
        ],
        uiAnimations: {
            spriteContent: self.getResource().getContent("menu"),
            animation:"commandervideo_hud",
            animation_happy:"commandervideo_hud_happy",
            animation_sad:"commandervideo_hud_sad",
            animation_angry:"commandervideo_hud_angry",
            animation_hurt:"commandervideo_hud_hurt"
        }
    }
];
exports.endTransformationAttack = function() {
    self.playFrame(self.getCurrentFrame() + 1);
    self.resume();
}

// start general functions --- 

//Runs on object init
function initialize(){
    self.addEventListener(EntityEvent.STATE_CHANGE, function() {
        if (canClutch()) {
            clutchAvaliable.set(true);
        }
        else {
            clutchAvaliable.set(false);
        }
    }, {persistent: true});
    var transShader = new HsbcColorFilter();
    heldTransformationFilter.set(transShader);

    Engine.log(self.getPlayerConfig().costume);
    if (self.getPlayerConfig().costume == 52) {
		__goldSparkleStart();
	}
}

function update(){
    if (heldTransformationData.get() != null) {
        heldTransformationFilter.get().brightness = Math.sin((match.getElapsedFrames() % (Math.PI * TRANSFORMATION_FLASH_RATE)) / TRANSFORMATION_FLASH_RATE) * TRANSFORMATION_BRIGHTNESS;
    }

    if (self.getAnimation() == "special_up_loop") {
        for (i in 0...self.getFoes().length){
            var foe = self.getFoes()[i];
            var xBuffer = 24;

            var skip = false;
            for (f in upSpecIgnoreList.get()) {
                if (f.getUid() == foe.getUid()) {
                    skip = true;
                    break;
                }
            }

            if (skip) { continue; }

            if (self.getYVelocity() >= 0 && self.getX() > foe.getEcbLeftHipX() + foe.getX() - xBuffer && self.getX() < foe.getEcbRightHipX() + foe.getX() + xBuffer){
                if (self.getY() < foe.getY() + foe.getEcbFootY() - 10 && self.getY() > foe.getY() + foe.getEcbHeadY()) {
                    self.setY(foe.getY() + foe.getEcbHeadY() + 16);
                    match.createVfx(new VfxStats({
                        spriteContent: "global::vfx.vfx",
                        animation: GlobalVfx.SPIKE_BACK,
                        layer: VfxLayer.BACKGROUND_EFFECTS,
                        x: self.getX(),
                        y: self.getY()
                    }));

                    self.setYVelocity(-12);
                    self.setXVelocity(self.getXVelocity() / 2);

                    foe.takeHit(new HitboxStats(UP_SPECIAL_HITBOXSTATS));
                    self.bringInFront(foe);
                    self.forceStartHitstop(foe.getHitstop(), true);
                    self.playAnimation("special_up_bounce");

                    upSpecIgnoreList.get().push(foe);
                    self.addTimer(UP_SPECIAL_COOLDOWN_TIME, 1, function() {
                        upSpecIgnoreList.get().remove(foe);
                    }, {persistent: true});
                }
            }
        }
    }
}

function onWavedash() {
    self.playAnimation("airdash_land_" + Random.getInt(0, 5));
    var vfx = match.createVfx(new VfxStats({
        spriteContent:self.getResource().getContent("framy"),
        animation: "vfx_wavedash_" + Random.getInt(0, WAVEDASH_TEXT_COUNT),
        layer: VfxLayer.FOREGROUND_EFFECTS,
        rotation: Random.getInt(-10, 10),
        x: self.getX(),
        y: self.getY(),
    }, self));
    vfx.setAlpha(0.75);
}

function sideSpecialSuccess(event:GameObjectEvent) {
    var vfx = match.createVfx(new VfxStats({
        spriteContent: self.getResource().getContent("framy"),
        animation: "vfx_magic_hit_light",
        x: event.data.foe.getX(),
        y: event.data.foe.getY() + event.data.foe.getEcbRightHipY(),
        layer: VfxLayer.BACKGROUND_EFFECTS,
        rotation: Random.getInt(0, 360)
    }));
    vfx.pause();
    vfx.addTimer(event.data.foe.getHitstop(), 1, vfx.resume);


    if (TRANSFORMATION_BASE_CAST_DATA.exists(event.data.foe.getGameObjectStat("spriteContent"))) {
        obtainTransformation(TRANSFORMATION_BASE_CAST_DATA.get(event.data.foe.getGameObjectStat("spriteContent")));
        self.playAnimation("special_side_transform_intro");
    }
}

function obtainTransformation(transformationData) {
    heldTransformationData.set(transformationData);

    if (heldTransformationHudSprite.get() != null) {
        heldTransformationHudSprite.get().dispose();
        heldTransformationHudSprite.set(null);
    }
    var hudSpr = Sprite.create(heldTransformationData.get().uiAnimations.spriteContent);
    hudSpr.currentAnimation = heldTransformationData.get().uiAnimations.animation;
    hudSpr.addShader(self.getCostumeShader());
    hudSpr.x = 21;
    hudSpr.y = 17;
    self.getDamageCounterContainer().addChild(hudSpr);
    heldTransformationHudSprite.set(hudSpr);

    self.setDamageCounterName(self.getDefaultDamageCounterName() + " (" + transformationData.abilityName + ")");
    self.getDamageCounterRenderSprite().visible = false;
    self.getDamageCounterRenderSpriteFront().visible = false;

    self.addFilter(heldTransformationFilter.get());
}

function removeTransformation() {
    heldTransformationData.set(null);
    if (heldTransformationHudSprite.get() != null) {
        heldTransformationHudSprite.get().dispose();
        heldTransformationHudSprite.set(null);
    }

    self.getDamageCounterRenderSprite().visible = true;
    self.getDamageCounterRenderSpriteFront().visible = true;
    self.setDamageCounterName(self.getDefaultDamageCounterName());

    self.removeFilter(heldTransformationFilter.get());
}

function attackInterrupt(state) {
    if (self.getAnimation() == "special_up_loop" && (state == CState.SPECIAL_NEUTRAL || state == CState.SPECIAL_SIDE || state == CState.SPECIAL_UP || state == CState.SPECIAL_DOWN)) {
        return true;
    }
    return false;
}


function onTeardown() {
	
}

// --- end general functions

// Clutch Reversal logic

function inputUpdateHook(pressedControls:ControlsObject, heldControls:ControlsObject) {
	if (self.isFirstInputUpdate()) {
        clutchButtonWasHeld.set(clutchButtonHeld.get());
		clutchButtonHeld.set(heldControls.SHIELD2);
        if (pressedControls.SHIELD2 && clutchAvaliable.get()) {
            self.setXVelocity(-1 * self.getXVelocity());
            self.flip();

            if (heldTransformationObject.get() != null && !heldTransformationObject.get().isDisposed()) {
                heldTransformationObject.get().flip();
                heldTransformationObject.get().setXVelocity(-1 * heldTransformationObject.get().getXVelocity());
            }

            match.createVfx(new VfxStats({
                spriteContent:self.getResource().getContent("framy"),
                animation: "vfx_clutch_front",
                layer: VfxLayer.FOREGROUND_EFFECTS,
                x: self.getX(),
                y: self.getY() + self.getEcbRightHipY(),
                scaleX: self.isFacingLeft() ? -1 : 1
            }));
            match.createVfx(new VfxStats({
                spriteContent:self.getResource().getContent("framy"),
                animation: "vfx_clutch_back",
                layer: VfxLayer.BACKGROUND_EFFECTS,
                x: self.getX(),
                y: self.getY() + self.getEcbRightHipY() - 2,
                scaleX: self.isFacingLeft() ? -1 : 1
            }));

            clutchAvaliable.set(false);
        }
	}

	pressedControls.SHIELD2 = false;
	heldControls.SHIELD2 = false;
}

//Rapid Jab logic
function jab3Loop(){
    if (self.getHeldControls().ATTACK) {
    	self.playFrame(2);
        Common.startJabComboCheck(); // responsible for allowing you to mash attack button in addition to holding
	} else {
		Common.playFrameIfTrue(2);
		Common.startJabComboCheck(); // responsible for allowing you to mash attack button in addition to holding
	}
}
//-----------NEUTRAL SPECIAL-----------

//projectile
function fireNSpecialProjectile(){
    neutralSpecialProjectile.set(match.createProjectile(self.getResource().getContent("characterTemplateNspecProjectile"), self));
    neutralSpecialProjectile.get().setX(self.getX() + self.flipX(NSPEC_PROJ_X_OFFSET));
    neutralSpecialProjectile.get().setY(self.getY() + NSPEC_PROJ_Y_OFFSET);
}

//cooldown timer
function startNeutralSpecialCooldown(){
    disableNeutralSpecial();
    self.addTimer(NEUTRAL_SPECIAL_COOLDOWN, 1, enableNeutralSpecial, {persistent:true});
}

function disableNeutralSpecial(){
    if (lastDisabledNSpecStatusEffect.get() != null) {
        self.removeStatusEffect(StatusEffectType.DISABLE_ACTION, lastDisabledNSpecStatusEffect.get().id);
    }
    lastDisabledNSpecStatusEffect.set(self.addStatusEffect(StatusEffectType.DISABLE_ACTION, CharacterActions.SPECIAL_NEUTRAL));
}

function enableNeutralSpecial(){
    if (lastDisabledNSpecStatusEffect.get() != null) {
        self.removeStatusEffect(StatusEffectType.DISABLE_ACTION, lastDisabledNSpecStatusEffect.get().id);
        lastDisabledNSpecStatusEffect.set(null);
    }
}

//-----------SIDE SPECIAL-----------

//shield hit slowdown 
function sideSpecialShieldHit(){
	self.setXSpeed(-4);
}

//jump cancel hit confirm
function sideSpecialHit(){
	self.updateAnimationStats({allowJump: true});
}

//-----------DOWN SPECIAL-----------

function specialDown_gotoEndlag(){
    if(self.isOnFloor()){
        self.playAnimation("special_down_endlag");
    } else {
        self.playAnimation("special_down_air_endlag");
    }
}

function specialDown_resetTimer(){
    self.removeTimer(downSpecialLoopCheckTimer.get());
    downSpecialLoopCheckTimer.set(-1);
}

function specialDown_checkLoop(){
    var heldControls:ControlsObject = self.getHeldControls();

    if(!heldControls.SPECIAL){
        specialDown_resetTimer();
        specialDown_gotoEndlag();
    }
}

function specialDown_gotoLoop(){
    if(self.isOnFloor()){
        self.playAnimation("special_down_loop");
    } else {
        self.playAnimation("special_down_air_loop");
    }

    //failsafe
    specialDown_resetTimer();

    // start checking inputs
    downSpecialLoopCheckTimer.set(self.addTimer(1, -1, specialDown_checkLoop));    
}