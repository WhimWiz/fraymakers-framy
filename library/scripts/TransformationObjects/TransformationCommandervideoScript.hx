
function initialize() {
    self.setX(self.getOwner().getX());
    self.setY(self.getOwner().getY());
    if (self.getOwner().isFacingLeft()) {
        self.faceLeft();
    }
}