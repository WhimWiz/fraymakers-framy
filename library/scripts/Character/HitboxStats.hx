// Hitbox stats
{
	//LIGHT ATTACKS
	jab1: {
		hitbox0: { damage: 2, angle: 80, baseKnockback: 20, knockbackGrowth: 5, hitstop: -1, selfHitstop: -1, limb:AttackLimb.FIST }
	},
	jab2: {
		hitbox0: { damage: 3, angle: 80, baseKnockback: 20, knockbackGrowth: 5, hitstop: -1, selfHitstop: -1, limb:AttackLimb.FIST }
	},
	jab3: {
		hitbox0: { damage: 1, angle: 85, baseKnockback: 17, knockbackGrowth: 0, hitstop: 1, selfHitstop: 3, hitstopNudgeMultiplier: 0.5, limb:AttackLimb.FOOT }
	},
	dash_attack: {
		hitbox0: {damage: 11, angle: 45, baseKnockback: 55, knockbackGrowth: 80, hitstop:-1, selfHitstop:-1, limb:AttackLimb.FOOT }
	},	
	tilt_forward: {
		hitbox0: { damage: 11, knockbackGrowth: 60, baseKnockback: 50, angle: 38, limb:AttackLimb.FOOT },
		hitbox1: { damage: 14, knockbackGrowth: 70, baseKnockback: 60, angle: 30, limb:AttackLimb.FOOT }
	},
	tilt_up: {
		hitbox0: { damage: 8, knockbackGrowth: 55, baseKnockback: 55, angle: 90, limb:AttackLimb.FIST },
	},
	tilt_down: {
		hitbox0: { damage: 7, angle: 65, baseKnockback: 65, knockbackGrowth: 65, hitstop: -1, selfHitstop: -1, limb:AttackLimb.FOOT},
		hitbox1: { damage: 7, angle: 65, baseKnockback: 65, knockbackGrowth: 65, hitstop: -1, selfHitstop: -1, limb:AttackLimb.FOOT}
	},

	//STRONG ATTACKS
	strong_forward_attack: {
		hitbox0: {damage: 13, angle: 40, baseKnockback: 68, knockbackGrowth: 75, hitstop: -1, selfHitstop:-1, limb:AttackLimb.FOOT}
	},
	strong_up_attack: {
		hitbox0: { damage: 10, knockbackGrowth: 70, baseKnockback: 60, hitstop: -1, hitstun: -1, angle: 80, limb:AttackLimb.FIST },
		hitbox1: { damage: 10, knockbackGrowth: 70, baseKnockback: 60, hitstop: -1, hitstun: -1, angle: 80, limb:AttackLimb.FIST },
		hitbox2: { damage: 12, knockbackGrowth: 80, baseKnockback: 65, hitstop: -1, selfHitstop:-1, hitstopOffset:3, selfHitstopOffset:3, angle: 90, limb:AttackLimb.FIST }
	},
	strong_down_attack: {
		hitbox0: {damage: 7, angle: 270, baseKnockback: 65, knockbackGrowth: 80, hitstop: -1, selfHitstop:-1, buryType: BuryType.BURY, buryTimeBase: 30, buryTimeScaling: 1.5, limb:AttackLimb.BODY}
	},

	//AERIAL ATTACKS
	aerial_neutral: /*{
		hitbox0: { damage: 10, angle: 361, baseKnockback: 40, knockbackGrowth: 65, hitstop:-1, selfHitstop:-1, limb:AttackLimb.FOOT},
		hitbox1: { damage: 10, angle: 361, baseKnockback: 40, knockbackGrowth: 65, hitstop:-1, selfHitstop:-1, limb:AttackLimb.FOOT}
	}*/{
		hitbox0: { damage: 4, angle: 45, baseKnockback: 66, knockbackGrowth: 5, hitstop: -1, selfHitstop: -1, reversibleAngle: false, limb:AttackLimb.FOOT },
		hitbox1: { damage: 7, angle: 65, baseKnockback: 77, knockbackGrowth: 35, hitstop: -1, selfHitstop: -1, reversibleAngle: false, limb:AttackLimb.FOOT}
	},
	aerial_forward: {
		hitbox0: { damage: 10, angle: 315, knockbackGrowth: 25, baseKnockback: 30, hitstop: -1, selfHitstop: -1, limb:AttackLimb.FIST },
		hitbox1: { damage: 14, angle: 278, knockbackGrowth: 35, baseKnockback: 35, hitstop: -1, selfHitstop: -1, hitstopOffset:3, selfHitstopOffset:3, limb:AttackLimb.FIST, tumbleType: TumbleType.ALWAYS}
	},
	/*aerial_forward: {
		hitbox0: { damage: 3, angle: SpecialAngle.AUTOLINK_STRONGER, knockbackGrowth: 0, baseKnockback: 60, hitstop: -1, selfHitstop: -1, limb:AttackLimb.BODY, reversibleAngle: false },
		hitbox1: { damage: 7, angle: 65, knockbackGrowth: 45, baseKnockback: 55, hitstop: -1, selfHitstop: -1, limb:AttackLimb.BODY, reversibleAngle: false }
	},*/
	aerial_back: {
		hitbox0: { damage: 2, angle: SpecialAngle.AUTOLINK_STRONGER, knockbackGrowth: 0, baseKnockback: 50, hitstop: -1, selfHitstop: -1, limb:AttackLimb.BATTERING, reversibleAngle: false },
		hitbox1: { damage: 7, angle: 115, knockbackGrowth: 55, baseKnockback: 60, hitstop: -1, selfHitstop: -1, hitstopOffset:3, selfHitstopOffset:3, limb:AttackLimb.BATTERING, reversibleAngle: false}
	},
	aerial_up: {
		hitbox0: { damage: 7, knockbackGrowth: 40, baseKnockback: 55, hitstop: -1, selfHitstop: -1, hitstun: -1, angle:75, limb:AttackLimb.FIST },
		hitbox1: { damage: 12, knockbackGrowth: 70, baseKnockback: 65, hitstop: -1, selfHitstop: -1, hitstun: -1, angle:85, limb:AttackLimb.FIST }
	},
	aerial_down: {
		hitbox0: { damage: 9, angle: 150, baseKnockback: 45, knockbackGrowth: 40, hitstop:-1, selfHitstop:-1, limb:AttackLimb.FOOT, reversibleAngle: false },
		hitbox1: { damage: 12, angle: 160, baseKnockback: 60, knockbackGrowth: 55, hitstop:-1, selfHitstop:-1, limb:AttackLimb.FOOT, reversibleAngle: false }
	},

	//SPECIAL ATTACKS
	special_neutral: {
		hitbox0: {}
	},
	special_neutral_air: {
		hitbox0: {}
	},
	special_side: {
		hitbox0: { damage: 1, knockbackGrowth: 0, baseKnockback: 80, hitstop: 2, selfHitstop:2, hitstun: -1, hitstopNudgeMultiplier:0, directionalInfluence: false, reversibleAngle: false, angle: SpecialAngle.AUTOLINK_STRONGER, jabResetType:JabResetType.NEVER, limb:AttackLimb.FIST, knockbackCap:75 },
		hitbox1: { damage: 1, knockbackGrowth: 0, baseKnockback: 80, hitstop: 2, selfHitstop:2, hitstun: -1, hitstopNudgeMultiplier:0, directionalInfluence: false, reversibleAngle: false, angle: SpecialAngle.AUTOLINK_STRONGER, jabResetType:JabResetType.NEVER, limb:AttackLimb.FIST, knockbackCap:75 },
	},
	special_side_air: {
		hitbox0: { damage: 1, knockbackGrowth: 50, baseKnockback: 80, hitstop: 2, selfHitstop:2, hitstun: -1, hitstopNudgeMultiplier:0, directionalInfluence: false, reversibleAngle: false, angle: SpecialAngle.AUTOLINK_STRONGER, jabResetType:JabResetType.NEVER, limb:AttackLimb.FIST, knockbackCap:75 },
		hitbox1: { damage: 1, knockbackGrowth: 50, baseKnockback: 80, hitstop: 2, selfHitstop:2, hitstun: -1, hitstopNudgeMultiplier:0, directionalInfluence: false, reversibleAngle: false, angle: SpecialAngle.AUTOLINK_STRONGER, jabResetType:JabResetType.NEVER, limb:AttackLimb.FIST, knockbackCap:75 },
	},
	special_up: {
		hitbox0: {damage: 2, knockbackGrowth: 100, baseKnockback: 140, hitstop: 2, selfHitstop: 2, hitstun: -1, hitstopNudgeMultiplier:0, directionalInfluence: false, reversibleAngle: false, angle: SpecialAngle.AUTOLINK_STRONGER, limb:AttackLimb.FIST, knockbackCap:75}
	}, 
	special_up_air: {
		hitbox0: {damage: 2, knockbackGrowth: 100, baseKnockback: 140, hitstop: 2, selfHitstop: 2, hitstun: -1, hitstopNudgeMultiplier:0, directionalInfluence: false, reversibleAngle: false, angle: SpecialAngle.AUTOLINK_STRONGER, limb:AttackLimb.FIST, knockbackCap:75}
	}, 
	special_down: {
		hitbox0: { damage:4, angle:90, baseKnockback: 85, knockbackGrowth: 30, hitstop: -1, selfHitstop: -1}
	}, 
	special_down_air: {
		hitbox0: { damage:4, angle:90, baseKnockback: 85, knockbackGrowth: 30, hitstop: -1, selfHitstop: -1}
	},

	//THROWS
	throw_down: {
		hitbox0: { damage: 7, angle: 45, baseKnockback: 55, knockbackGrowth: 65, hitstop: -1, selfHitstop:-1, reversibleAngle: false, limb:AttackLimb.BODY }
	},
	throw_up: {
		hitbox0: { damage: 8, angle: 95, baseKnockback: 55, knockbackGrowth: 65, hitstop: -1, selfHitstop:-1, reversibleAngle: false, limb:AttackLimb.HEAD }
	},
	throw_forward: {
		hitbox0: { damage: 8, angle: 45, baseKnockback: 55, knockbackGrowth: 45, hitstop:0, selfHitstop:0, reversibleAngle: false, hitSoundOverride: "#n/a", hitEffectOverride: "#n/a", cameraShakeType: CameraShakeType.NONE }
	},
	throw_back: { 
		hitbox0: { damage: 8, angle: 145, baseKnockback: 55, knockbackGrowth: 45, hitstop:0, selfHitstop:0, reversibleAngle: false, hitSoundOverride: "#n/a", hitEffectOverride: "#n/a", cameraShakeType: CameraShakeType.NONE }
	},
	
	//MISC ATTACKS
	ledge_attack: {
		hitbox0: { damage: 9, angle: 361, baseKnockback: 40, knockbackGrowth: 60, hitstop:-1, selfHitstop:-1, limb:AttackLimb.FOOT},
		hitbox1: { damage: 9, angle: 361, baseKnockback: 40, knockbackGrowth: 60, hitstop:-1, selfHitstop:-1, limb:AttackLimb.FOOT}
	},
	crash_attack: {
		hitbox0: { damage: 6, angle: 35, baseKnockback: 70, knockbackGrowth: 25, hitstop: -1, selfHitstop:-1, limb:AttackLimb.FOOT }
	},
	emote: {
		hitbox0: {}
	}

	//UNUSED ATTACKS (Example attacks that are currently not used. You can rename the HitboxStats and the animation if you'd like to replace an existing animation.)
	/*
	aerial_neutral (multi-hit): {
		hitbox0: { damage: 1, angle: 40, baseKnockback: 60, knockbackGrowth: 0, hitstop: -1, selfHitstop: -1, reversibleAngle: false, limb:AttackLimb.FOOT },
		hitbox1: { damage: 1, angle: 40, baseKnockback: 60, knockbackGrowth: 0, hitstop: -1, selfHitstop: -1, reversibleAngle: false, limb:AttackLimb.FOOT}
	},
	*/
}
