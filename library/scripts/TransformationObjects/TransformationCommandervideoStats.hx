STATE_ACTIVE = 0;

{
    spriteContent: self.getResource().getContent("framy"),
    initialState: STATE_ACTIVE,
    stateTransitionMapOverrides: [
		STATE_ACTIVE => {
			animation: "transformation_commandervideo_attack"
		}
	],
    gravity: 0,
    ghost: true, 
    immovable: true
}