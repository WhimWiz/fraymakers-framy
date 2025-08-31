
var X_OFFSET = 46;
var Y_OFFSET = 0;

S_INTRO = 0;
S_IDLE = 1;
S_OUTRO = 2;

Common.initLocalStateMachine();
Common.registerLocalState(S_INTRO, "assist_intro");
Common.registerLocalState(S_IDLE, "assist_idle");
Common.registerLocalState(S_OUTRO, "assist_outro");

function initialize() {
    self.setX(self.getOwner().getX() + self.getOwner().flipX(X_OFFSET));
    self.setY(self.getOwner().getY());

    if (self.getOwner().isFacingLeft()) {
        self.faceLeft();
    }

    Common.startFadeIn();
    Common.toLocalState(S_INTRO);
}