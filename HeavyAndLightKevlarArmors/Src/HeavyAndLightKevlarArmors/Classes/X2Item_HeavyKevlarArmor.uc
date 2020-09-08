class X2Item_HeavyKevlarArmor extends X2Item config(HeavyAndLightKevlarArmors);
	
	var config int HEAVY_KEVLAR_HEALTH_BONUS;
	var config int HEAVY_KEVLAR_MITIGATION_BONUS;
	var config int HEAVY_KEVLAR_MOBILITY_MALUS;

static function array<X2DataTemplate> CreateTemplates() {

	local array<X2DataTemplate> Armors;

	Armors.AddItem(CreateHeavyKevlarArmor());
	
	return Armors;

}

static function X2DataTemplate CreateHeavyKevlarArmor() {

	local X2ArmorTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ArmorTemplate', Template, 'HeavyKevlarArmor');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_Kevlar_Armor";
	Template.bAddsUtilitySlot = false;
	Template.StartingItem = true;
	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;
	Template.Abilities.AddItem('HeavyKevlarArmorStats');
	Template.ArmorTechCat = 'conventional';
	Template.ArmorClass = 'heavy';
	Template.ArmorCat = 'soldier';
	Template.Tier = 0;
	Template.AkAudioSoldierArmorSwitch = 'Conventional';
	Template.EquipSound = "StrategyUI_Armor_Equip_Conventional";

	Template.SetUIStatMarkup(class'XLocalizedData'.default.HealthLabel, eStat_HP, class'X2Ability_HeavyAndLightKevlarArmors'.default.HEAVY_KEVLAR_HEALTH_BONUS, true);
	Template.SetUIStatMarkup(class'XLocalizedData'.default.ArmorLabel, eStat_ArmorMitigation, class'X2Ability_HeavyAndLightKevlarArmors'.default.HEAVY_KEVLAR_MITIGATION_BONUS, true);
	Template.SetUIStatMarkup(class'XLocalizedData'.default.MobilityLabel, eStat_Mobility, class'X2Ability_HeavyAndLightKevlarArmors'.default.HEAVY_KEVLAR_MOBILITY_MALUS, true);

	return Template;

}