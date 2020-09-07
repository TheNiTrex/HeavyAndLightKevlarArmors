class X2Ability_HeavyAndLightKevlarArmors extends X2Ability
	dependson (XComGameStateContext_Ability) config(GameCore);

	var config config(HeavyAndLightKevlarArmors) int MEDIUM_KEVLAR_HEALTH_BONUS;
	
	var config config(HeavyAndLightKevlarArmors) int HEAVY_KEVLAR_HEALTH_BONUS;
	var config config(HeavyAndLightKevlarArmors) int HEAVY_KEVLAR_MITIGATION_BONUS;
	var config config(HeavyAndLightKevlarArmors) int HEAVY_KEVLAR_MOBILITY_MALUS;

	var config config(HeavyAndLightKevlarArmors) int LIGHT_KEVLAR_MOBILITY_BONUS;

static function array<X2DataTemplate> CreateTemplates() {

	local array<X2DataTemplate> Templates;

	Templates.AddItem(MediumKevlarArmorStats());
	Templates.AddItem(HeavyKevlarArmorStats());
	Templates.AddItem(LightKevlarArmorStats());

	return Templates;

}

static function X2AbilityTemplate MediumKevlarArmorStats() {

	local X2AbilityTemplate Template;	
	local X2AbilityTrigger Trigger;
	local X2AbilityTarget_Self	TargetStyle;
	local X2Effect_PersistentStatChange PersistentStatChangeEffect;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'MediumKevlarArmorStats');

	Template.AbilitySourceName = 'eAbilitySource_Item';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.bDisplayInUITacticalText = false;

	Template.AbilityToHitCalc = default.DeadEye;

	TargetStyle = new class'X2AbilityTarget_Self';
	Template.AbilityTargetStyle = TargetStyle;

	Trigger = new class'X2AbilityTrigger_UnitPostBeginPlay';
	Template.AbilityTriggers.AddItem(Trigger);

	PersistentStatChangeEffect = new class'X2Effect_PersistentStatChange';
	PersistentStatChangeEffect.BuildPersistentEffect(1, true, false, false);
	PersistentStatChangeEffect.AddPersistentStatChange(eStat_HP, default.MEDIUM_KEVLAR_HEALTH_BONUS);
	Template.AddTargetEffect(PersistentStatChangeEffect);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;

	return Template;	

}

static function X2AbilityTemplate HeavyKevlarArmorStats() {

	local X2AbilityTemplate Template;	
	local X2AbilityTrigger Trigger;
	local X2AbilityTarget_Self	TargetStyle;
	local X2Effect_PersistentStatChange PersistentStatChangeEffect;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'HeavyKevlarArmorStats');

	Template.AbilitySourceName = 'eAbilitySource_Item';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.bDisplayInUITacticalText = false;

	Template.AbilityToHitCalc = default.DeadEye;

	TargetStyle = new class'X2AbilityTarget_Self';
	Template.AbilityTargetStyle = TargetStyle;

	Trigger = new class'X2AbilityTrigger_UnitPostBeginPlay';
	Template.AbilityTriggers.AddItem(Trigger);

	PersistentStatChangeEffect = new class'X2Effect_PersistentStatChange';
	PersistentStatChangeEffect.BuildPersistentEffect(1, true, false, false);
	PersistentStatChangeEffect.AddPersistentStatChange(eStat_HP, default.HEAVY_KEVLAR_HEALTH_BONUS);
	PersistentStatChangeEffect.AddPersistentStatChange(eStat_ArmorMitigation, default.HEAVY_KEVLAR_MITIGATION_BONUS);
	PersistentStatChangeEffect.AddPersistentStatChange(eStat_Mobility, default.HEAVY_KEVLAR_MOBILITY_MALUS);
	Template.AddTargetEffect(PersistentStatChangeEffect);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;

	return Template;	

}

static function X2AbilityTemplate LightKevlarArmorStats() {

	local X2AbilityTemplate Template;	
	local X2AbilityTrigger Trigger;
	local X2AbilityTarget_Self	TargetStyle;
	local X2Effect_PersistentStatChange PersistentStatChangeEffect;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'LightKevlarArmorStats');

	Template.AbilitySourceName = 'eAbilitySource_Item';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.bDisplayInUITacticalText = false;

	Template.AbilityToHitCalc = default.DeadEye;

	TargetStyle = new class'X2AbilityTarget_Self';
	Template.AbilityTargetStyle = TargetStyle;

	Trigger = new class'X2AbilityTrigger_UnitPostBeginPlay';
	Template.AbilityTriggers.AddItem(Trigger);

	PersistentStatChangeEffect = new class'X2Effect_PersistentStatChange';
	PersistentStatChangeEffect.BuildPersistentEffect(1, true, false, false);
	PersistentStatChangeEffect.AddPersistentStatChange(eStat_Mobility, default.LIGHT_KEVLAR_MOBILITY_BONUS);
	Template.AddTargetEffect(PersistentStatChangeEffect);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;

	return Template;	

}