
var heldTransformationData = self.makeObject(null);
var heldTransformationObject = self.makeObject(null);
var heldTransformationOffscreenSprite = self.makeObject(null);
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

function initialize() {
    Engine.log("ASSIST IS REAL");
}

function update() {
    
}