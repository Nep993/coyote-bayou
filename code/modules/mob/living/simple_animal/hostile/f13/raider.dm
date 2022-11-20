// IN THIS FILE: -All Raider Mobs

///////////////////
// BASIC RAIDERS //
///////////////////

// BASIC MELEE RAIDER
/mob/living/simple_animal/hostile/raider
	name = "Raider"
	desc = "Another murderer churned out by the wastes."
	icon = 'icons/fallout/mobs/humans/raider.dmi'
	icon_state = "raider_melee"
	icon_living = "raider_melee"
	icon_dead = "raider_dead"
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	turns_per_move = 5
	mob_armor = ARMOR_VALUE_RAIDER_LEATHER_JACKET
	maxHealth = 100
	health = 100
	melee_damage_lower = 5
	melee_damage_upper = 14
	attack_verb_simple = "clobbers"
	attack_sound = 'sound/weapons/bladeslice.ogg'
	a_intent = INTENT_HARM
	faction = list("raider")
	check_friendly_fire = TRUE
	status_flags = CANPUSH
	del_on_death = FALSE
	loot = list(/obj/item/melee/onehanded/knife/survival, /obj/item/stack/f13Cash/random/med)
	footstep_type = FOOTSTEP_MOB_SHOE
	rapid_melee = 2
	melee_queue_distance = 5
	move_to_delay = 3.1
	waddle_amount = 2
	waddle_up_time = 1
	waddle_side_time = 1
	retreat_distance = 1 //mob retreats 1 tile when in min distance
	minimum_distance = 1 //Mob pushes up to melee, then backs off to avoid player attack?
	aggro_vision_range = 6 //mob waits to attack if the player chooses to close distance, or if the player attacks first.
	vision_range = 8 //will see the player at max view range, and communicate that they've been seen but won't aggro unless they get closer.
	variation_list = list(
		MOB_NAME_FROM_GLOBAL_LIST(\
			MOB_RANDOM_NAME(MOB_NAME_RANDOM_MALE, 1)\
		))

/obj/effect/mob_spawn/human/corpse/raider
	name = "Raider"
	uniform = /obj/item/clothing/under/f13/rag
	suit = /obj/item/clothing/suit/armor/medium/raider/iconoclast
	shoes = /obj/item/clothing/shoes/f13/explorer
	gloves = /obj/item/clothing/gloves/f13/leather
	head = /obj/item/clothing/head/helmet/f13/firefighter

/mob/living/simple_animal/hostile/raider/Aggro()
	..()
	summon_backup(15)
	say(pick("*insult", "Fuck off!!", "Back off!!" , "Keep moving!!", "Get lost, asshole!!", "Call a doctor, we got a bleeder!!", "Fuck around and find out!!" ))

// THIEF RAIDER - nabs stuff and runs
/mob/living/simple_animal/hostile/raider/thief
	desc = "Another murderer churned out by the wastes. This one looks like they have sticky fingers..."

/mob/living/simple_animal/hostile/raider/thief/movement_delay()
	return -2

/mob/living/simple_animal/hostile/raider/thief/AttackingTarget()
	if(ishuman(target))
		var/mob/living/carbon/human/H = target
		if(H.stat == SOFT_CRIT)
			var/back_target = H.back
			if(back_target)
				H.dropItemToGround(back_target, TRUE)
				src.transferItemToLoc(back_target, src, TRUE)
			var/belt_target = H.belt
			if(belt_target)
				H.dropItemToGround(belt_target, TRUE)
				src.transferItemToLoc(belt_target, src, TRUE)
			var/shoe_target = H.shoes
			if(shoe_target)
				H.dropItemToGround(shoe_target, TRUE)
				src.transferItemToLoc(shoe_target, src, TRUE)
			retreat_distance = 50
		else
			. = ..()

/mob/living/simple_animal/hostile/raider/thief/death(gibbed)
	for(var/obj/I in contents)
		src.dropItemToGround(I)
	. = ..()

// BASIC RANGED RAIDER
/mob/living/simple_animal/hostile/raider/ranged
	icon_state = "raider_ranged"
	icon_living = "raider_ranged"
	ranged = TRUE
	mob_armor = ARMOR_VALUE_RAIDER_LEATHER_JACKET
	maxHealth = 85
	health = 85
	rapid_melee = 2
	melee_queue_distance = 5
	move_to_delay = 2.8 //faster than average, but not a lot
	retreat_distance = 1 //mob retreats 1 tile when in min distance
	minimum_distance = 1 //Mob pushes up to melee, then backs off to avoid player attack?
	aggro_vision_range = 6 //mob waits to attack if the player chooses to close distance, or if the player attacks first.
	vision_range = 8 //will see the player at max view range, and communicate that they've been seen but won't aggro unless they get closer.
	projectiletype = /obj/item/projectile/bullet/c9mm/op
	projectilesound = 'sound/f13weapons/ninemil.ogg'
	loot = list(/obj/effect/spawner/lootdrop/f13/npc_raider, /obj/item/stack/f13Cash/random/med)
	footstep_type = FOOTSTEP_MOB_SHOE
	variation_list = list(
		MOB_NAME_FROM_GLOBAL_LIST(\
			MOB_RANDOM_NAME(MOB_NAME_RANDOM_FEMALE, 1)\
		))
	projectile_sound_properties = list(
		SP_VARY(FALSE),
		SP_VOLUME(PISTOL_LIGHT_VOLUME),
		SP_VOLUME_SILENCED(PISTOL_LIGHT_VOLUME * SILENCED_VOLUME_MULTIPLIER),
		SP_NORMAL_RANGE(PISTOL_LIGHT_RANGE),
		SP_NORMAL_RANGE_SILENCED(SILENCED_GUN_RANGE),
		SP_IGNORE_WALLS(TRUE),
		SP_DISTANT_SOUND(PISTOL_LIGHT_DISTANT_SOUND),
		SP_DISTANT_RANGE(PISTOL_LIGHT_RANGE_DISTANT)
	)


// LEGENDARY MELEE RAIDER
/mob/living/simple_animal/hostile/raider/legendary
	name = "Legendary Raider"
	desc = "Another murderer churned out by the wastes - this one seems a bit faster than the average..."
	color = "#FFFF00"
	mob_armor = ARMOR_VALUE_RAIDER_LEATHER_JACKET
	maxHealth = 300
	health = 300
	speed = 1.2
	obj_damage = 300
	rapid_melee = 1
	loot = list(/obj/item/melee/onehanded/knife/survival, /obj/item/reagent_containers/food/snacks/kebab/human, /obj/item/stack/f13Cash/random/high)
	footstep_type = FOOTSTEP_MOB_SHOE

// LEGENDARY RANGED RAIDER
/mob/living/simple_animal/hostile/raider/ranged/legendary
	name = "Legendary Raider"
	desc = "Another murderer churned out by the wastes, wielding a decent pistol and looking very strong"
	color = "#FFFF00"
	mob_armor = ARMOR_VALUE_RAIDER_LEATHER_JACKET
	maxHealth = 240
	health = 240
	retreat_distance = 1
	minimum_distance = 2
	rapid_melee = 1
	projectiletype = /obj/item/projectile/bullet/m44
	projectilesound = 'sound/f13weapons/44mag.ogg'
	extra_projectiles = 1
	obj_damage = 300
	loot = list(/obj/item/gun/ballistic/revolver/m29, /obj/item/stack/f13Cash/random/high)
	footstep_type = FOOTSTEP_MOB_SHOE
	projectile_sound_properties = list(
		SP_VARY(FALSE),
		SP_VOLUME(PISTOL_HEAVY_VOLUME),
		SP_VOLUME_SILENCED(PISTOL_HEAVY_VOLUME * SILENCED_VOLUME_MULTIPLIER),
		SP_NORMAL_RANGE(PISTOL_HEAVY_RANGE),
		SP_NORMAL_RANGE_SILENCED(SILENCED_GUN_RANGE),
		SP_IGNORE_WALLS(TRUE),
		SP_DISTANT_SOUND(PISTOL_HEAVY_DISTANT_SOUND),
		SP_DISTANT_RANGE(PISTOL_HEAVY_RANGE_DISTANT)
	)

// RAIDER BOSS
/mob/living/simple_animal/hostile/raider/ranged/boss
	name = "Raider Boss"
	icon_state = "raiderboss"
	icon_living = "raiderboss"
	icon_dead = "raiderboss_dead"
	mob_armor = ARMOR_VALUE_RAIDER_COMBAT_ARMOR_BOSS
	maxHealth = 150
	health = 150
	extra_projectiles = 2
	rapid_melee = 1
	waddle_amount = 4
	waddle_up_time = 2
	waddle_side_time = 1
	projectiletype = /obj/item/projectile/bullet/c45/op
	loot = list(/obj/item/gun/ballistic/automatic/smg/greasegun, /obj/item/clothing/head/helmet/f13/combat/mk2/raider, /obj/effect/spawner/lootdrop/f13/armor/randomraiderchest, /obj/item/clothing/under/f13/ravenharness, /obj/item/stack/f13Cash/random/high)
	footstep_type = FOOTSTEP_MOB_SHOE
	move_to_delay = 4.0 //faster than average, but not a lot
	retreat_distance = 4 //mob retreats 1 tile when in min distance
	minimum_distance = 3 //Mob pushes up to melee, then backs off to avoid player attack?
	aggro_vision_range = 6 //mob waits to attack if the player chooses to close distance, or if the player attacks first.
	vision_range = 8 //will see the player at max view range, and communicate that they've been seen but won't aggro unless they get closer.
	projectile_sound_properties = list(
		SP_VARY(FALSE),
		SP_VOLUME(PISTOL_MEDIUM_VOLUME),
		SP_VOLUME_SILENCED(PISTOL_MEDIUM_VOLUME * SILENCED_VOLUME_MULTIPLIER),
		SP_NORMAL_RANGE(PISTOL_MEDIUM_RANGE),
		SP_NORMAL_RANGE_SILENCED(SILENCED_GUN_RANGE),
		SP_IGNORE_WALLS(TRUE),
		SP_DISTANT_SOUND(PISTOL_MEDIUM_DISTANT_SOUND),
		SP_DISTANT_RANGE(PISTOL_MEDIUM_RANGE_DISTANT)
	)

/mob/living/simple_animal/hostile/raider/ranged/boss/Aggro()
	..()
	summon_backup(15)
	say("KILL 'EM, FELLAS!")

/mob/living/simple_animal/hostile/raider/ranged/boss/mangomatt
	name = "Mango Mathew and his Merry Meth Madlads"
	desc = "Hi, Mango Mathew and his Merry Meth Madlads."
	icon_state = "mango_matt"
	icon_living = "mango_matt"
	icon_dead = "mango_matt_dead"
	mob_armor = ARMOR_VALUE_RAIDER_COMBAT_ARMOR_BOSS
	maxHealth = 165
	health = 165
	extra_projectiles = 2
	speak_emote = list(
		"growls",
		"murrs",
		"purrs",
		"mrowls",
		"yowls",
		"prowls"
		)
	emote_see = list(
		"laughs",
		"nyas",
		""
		)
	attack_verb_simple = list(
		"claws",
		"maims",
		"bites",
		"mauls",
		"slashes",
		"thrashes",
		"bashes",
		"glomps",
		"beats their greasegun against the face of"
		)
	variation_list = list() // so he keeps his stupid name

/mob/living/simple_animal/hostile/raider/ranged/boss/mangomatt/Aggro()
	..()
	summon_backup(15)
	say(pick(\
		"*nya",\
		"*mrowl",\
		"*lynx",\
		"*cougar",\
		"*growl",\
		"*come",\
		"Fuck em' up!"\
		))

/mob/living/simple_animal/hostile/raider/ranged/boss/blueberrybates
	name = "Blueberry Bates and his Bottom-Feeder Buys"
	desc = "Hello, Blueberry Bates and his Bottom-Feeder Buys. Has a shotgun with APDS incendiary slugs and is ready to fucking kill you."
	icon_state = "blueberry_bates"
	icon_living = "blueberry_bates"
	icon_dead = "blueberry_bates_dead"
	mob_armor = ARMOR_VALUE_RAIDER_COMBAT_ARMOR_BOSS
	move_to_delay = 4 //S L O W
	projectiletype = /obj/item/projectile/bullet/incendiary/shotgun
	projectilesound = 'sound/f13weapons/shotgun.ogg'
	maxHealth = 200 //bit beefier since his arena is significantly shittier for him and he's more of an annoyance
	health = 200
	extra_projectiles = 0
	retreat_distance = 3
	minimum_distance = 3
	loot = list(/obj/item/stack/f13Cash/random/high, /obj/item/ammo_box/shotgun/incendiary, /obj/item/gun/ballistic/shotgun/police)
	speak_emote = list(
		"mutters",
		"counts his caps to himself",
		"yells at someone to pick up the pace",
		"barks",
		"grumbles",
		"grouches"
		)
	emote_see = list(
		"chitters",
		"idly gnaws on a hat",
		)
	attack_verb_simple = list(
		"bayonets",
		"smacks",
		"bites",
		"mauls",
		"slashes",
		"thrashes",
		"bashes",
		"glomps",
		"robusts on"
		)
	variation_list = list() // so he keeps his stupid name

/mob/living/simple_animal/hostile/raider/ranged/boss/blueberrybates/Aggro()
	..()
	summon_backup(15)
	say(pick(\
		"TO ME, BOYS!",\
		"KICK THEIR ASS!",\
		"Fuck 'em up!",\
		"*chitter",\
		"*kyaa",\
		"*come",\
		"YOU'RE ABOUT TO GET A DISCOUNT ON A GRAVE, BUDDY!",\
		))

// RANGED RAIDER WITH ARMOR
/mob/living/simple_animal/hostile/raider/ranged/sulphiteranged
	icon_state = "metal_raider"
	icon_living = "metal_raider"
	icon_dead = "metal_raider_dead"
	mob_armor = ARMOR_VALUE_RAIDER_METAL_ARMOR
	maxHealth = 60
	health = 60
	rapid_melee = 1
	projectiletype = /obj/item/projectile/bullet/c45/op
	projectilesound = 'sound/weapons/gunshot.ogg'
	loot = list(/obj/item/gun/ballistic/automatic/pistol/m1911/custom, /obj/item/clothing/suit/armor/heavy/metal/reinforced, /obj/item/clothing/head/helmet/f13/metalmask/mk2, /obj/item/stack/f13Cash/random/med)
	footstep_type = FOOTSTEP_MOB_SHOE
	projectile_sound_properties = list(
		SP_VARY(FALSE),
		SP_VOLUME(PISTOL_MEDIUM_VOLUME),
		SP_VOLUME_SILENCED(PISTOL_MEDIUM_VOLUME * SILENCED_VOLUME_MULTIPLIER),
		SP_NORMAL_RANGE(PISTOL_MEDIUM_RANGE),
		SP_NORMAL_RANGE_SILENCED(SILENCED_GUN_RANGE),
		SP_IGNORE_WALLS(TRUE),
		SP_DISTANT_SOUND(PISTOL_MEDIUM_DISTANT_SOUND),
		SP_DISTANT_RANGE(PISTOL_MEDIUM_RANGE_DISTANT)
	)

// FIREFIGHTER RAIDER
/mob/living/simple_animal/hostile/raider/firefighter
	icon_state = "firefighter_raider"
	icon_living = "firefighter_raider"
	icon_dead = "firefighter_raider_dead"
	mob_armor = ARMOR_VALUE_RAIDER_ARMOR
	maxHealth = 100
	health = 100
	loot = list(/obj/item/twohanded/fireaxe, /obj/item/stack/f13Cash/random/med)
	footstep_type = FOOTSTEP_MOB_SHOE
	rapid_melee = 1

// BIKER RAIDER
/mob/living/simple_animal/hostile/raider/ranged/biker
	icon_state = "biker_raider"
	icon_living = "biker_raider"
	icon_dead = "biker_raider_dead"
	melee_damage_lower = 10
	melee_damage_upper = 20
	mob_armor = ARMOR_VALUE_RAIDER_COMBAT_ARMOR_RUSTY
	maxHealth = 125
	health = 125
	rapid_melee = 1
	projectiletype = /obj/item/projectile/bullet/a556/match
	projectilesound = 'sound/f13weapons/magnum_fire.ogg'
	casingtype = /obj/item/ammo_casing/a556
	loot = list(/obj/item/gun/ballistic/revolver/thatgun, /obj/item/clothing/suit/armor/medium/combat/rusted, /obj/item/clothing/head/helmet/f13/raidercombathelmet, /obj/item/stack/f13Cash/random/med)
	footstep_type = FOOTSTEP_MOB_SHOE
	projectile_sound_properties = list(
		SP_VARY(FALSE),
		SP_VOLUME(RIFLE_LIGHT_VOLUME),
		SP_VOLUME_SILENCED(RIFLE_LIGHT_VOLUME * SILENCED_VOLUME_MULTIPLIER),
		SP_NORMAL_RANGE(RIFLE_LIGHT_RANGE),
		SP_NORMAL_RANGE_SILENCED(SILENCED_GUN_RANGE),
		SP_IGNORE_WALLS(TRUE),
		SP_DISTANT_SOUND(RIFLE_LIGHT_DISTANT_SOUND),
		SP_DISTANT_RANGE(RIFLE_LIGHT_RANGE_DISTANT)
	)

/obj/effect/mob_spawn/human/corpse/raider/ranged/biker
	uniform = /obj/item/clothing/under/f13/ncrcf
	suit = /obj/item/clothing/suit/armor/medium/combat/rusted
	shoes = /obj/item/clothing/shoes/f13/explorer
	gloves = /obj/item/clothing/gloves/f13/leather/fingerless
	head = /obj/item/clothing/head/helmet/f13/raidercombathelmet
	neck = /obj/item/clothing/neck/mantle/brown

// YANKEE RAIDER

/mob/living/simple_animal/hostile/raider/baseball
	icon_state = "baseball_raider"
	icon_living = "baseball_raider"
	icon_dead = "baseball_raider_dead"
	retreat_distance = 1
	minimum_distance = 1
	melee_damage_lower = 20
	melee_damage_upper = 40
	mob_armor = ARMOR_VALUE_RAIDER_ARMOR
	maxHealth = 125
	health = 125
	rapid_melee = 1
	loot = list(/obj/item/twohanded/baseball, /obj/item/stack/f13Cash/random/med)
	footstep_type = FOOTSTEP_MOB_SHOE


/obj/effect/mob_spawn/human/corpse/raider/baseball
	uniform = /obj/item/clothing/under/f13/mechanic
	suit = /obj/item/clothing/suit/armor/medium/raider/yankee
	shoes = /obj/item/clothing/shoes/f13/explorer
	gloves = /obj/item/clothing/gloves/f13/leather/fingerless
	head = /obj/item/clothing/head/helmet/f13/raider/yankee

// TRIBAL RAIDER

/mob/living/simple_animal/hostile/raider/tribal
	icon_state = "tribal_raider"
	icon_living = "tribal_raider"
	icon_dead = "tribal_raider_dead"
	mob_armor = ARMOR_VALUE_RAIDER_ARMOR
	maxHealth = 125
	health = 125
	melee_damage_lower = 15
	melee_damage_upper = 47
	loot = list(/obj/item/twohanded/spear)
	footstep_type = FOOTSTEP_MOB_SHOE
	rapid_melee = 1

/obj/effect/mob_spawn/human/corpse/raider/tribal
	uniform = /obj/item/clothing/under/f13/raiderrags
	suit = /obj/item/clothing/suit/armor/light/tribal
	shoes = /obj/item/clothing/shoes/f13/rag
	mask = /obj/item/clothing/mask/facewrap
	head = /obj/item/clothing/head/helmet/f13/fiend

//////////////
// SULPHITE //
//////////////

/mob/living/simple_animal/hostile/raider/sulphite
	name = "Sulphite Brawler"
	desc = "A raider with low military grade armor and a shishkebab"
	icon_state = "sulphite"
	icon_living = "sulphite"
	icon_dead= "sulphite_dead"
	mob_armor = ARMOR_VALUE_RAIDER_COMBAT_ARMOR_RUSTY
	maxHealth = 135
	health = 135
	rapid_melee = 1
	melee_damage_lower = 20
	melee_damage_upper = 47
	loot = list(/obj/item/stack/f13Cash/random/med)
	footstep_type = FOOTSTEP_MOB_SHOE

/////////////
// JUNKERS //
/////////////

/mob/living/simple_animal/hostile/raider/junker
	name = "Junker"
	desc = "A raider from the Junker gang."
	faction = list("raider", "wastebot")
	icon_state = "junker_hijacker"
	icon_living = "junker_hijacker"
	icon_dead = "junker_dead"
	mob_armor = ARMOR_VALUE_RAIDER_COMBAT_ARMOR_RUSTY
	maxHealth = 150
	health = 150
	rapid_melee = 1
	melee_damage_lower = 20
	melee_damage_upper = 55
	footstep_type = FOOTSTEP_MOB_SHOE

/mob/living/simple_animal/hostile/raider/ranged/boss/junker
	name = "Junker Footman"
	desc = "A Junker raider, outfitted in reinforced combat raider armor with extra metal plates."
	icon_state = "junker_scrapper"
	icon_living = "junker_scrapper"
	icon_dead = "junker_dead"
	faction = list("raider", "wastebot")
	mob_armor = ARMOR_VALUE_RAIDER_COMBAT_ARMOR_BOSS
	maxHealth = 165
	health = 165
	damage_coeff = list(BRUTE = 1, BURN = 0.75, TOX = 0, CLONE = 0, STAMINA = 0, OXY = 0)
	rapid_melee = 1
	melee_damage_lower = 25
	melee_damage_upper = 50
	footstep_type = FOOTSTEP_MOB_SHOE

/mob/living/simple_animal/hostile/raider/junker/creator
	name = "Junker Field Creator"
	desc = "A Junker raider, specialized in spitting out eyebots on the fly with any scrap they can find."
	icon_state = "junker"
	icon_living = "junker"
	icon_dead = "junker_dead"
	mob_armor = ARMOR_VALUE_RAIDER_COMBAT_ARMOR_RUSTY
	maxHealth = 150
	health = 150
	ranged = TRUE
	retreat_distance = 6
	minimum_distance = 8
	rapid_melee = 1
	projectiletype = /obj/item/projectile/bullet/c45/op
	projectilesound = 'sound/weapons/gunshot.ogg'
	var/list/spawned_mobs = list()
	var/max_mobs = 3
	var/mob_types = list(/mob/living/simple_animal/hostile/eyebot/reinforced)
	var/spawn_time = 15 SECONDS
	var/spawn_text = "flies from"
	footstep_type = FOOTSTEP_MOB_SHOE


/mob/living/simple_animal/hostile/raider/junker/creator/Initialize()
	. = ..()
	AddComponent(/datum/component/spawner, mob_types, spawn_time, faction, spawn_text, max_mobs, _range = 7)

/mob/living/simple_animal/hostile/raider/junker/creator/death()
	RemoveComponentByType(/datum/component/spawner)
	. = ..()

/mob/living/simple_animal/hostile/raider/junker/creator/Destroy()
	RemoveComponentByType(/datum/component/spawner)
	. = ..()

/mob/living/simple_animal/hostile/raider/junker/creator/Aggro()
	..()
	summon_backup(10)

/mob/living/simple_animal/hostile/raider/junker/boss
	name = "Junker Boss"
	desc = "A Junker boss, clad in hotrod power armor, and wielding a deadly rapid-fire shrapnel cannon."
	icon_state = "junker_boss"
	icon_living = "junker_boss"
	icon_dead = "junker_dead"
	mob_armor = ARMOR_VALUE_RAIDER_COMBAT_ARMOR_BOSS
	maxHealth = 165
	health = 165
	ranged = TRUE
	rapid_melee = 1
	retreat_distance = 4
	minimum_distance = 6
	extra_projectiles = 2
	ranged_cooldown_time = 15
	projectiletype = /obj/item/projectile/bullet/shrapnel
	projectilesound = 'sound/f13weapons/auto5.ogg'
	loot = list(/obj/item/stack/f13Cash/random/high)
	footstep_type = FOOTSTEP_MOB_SHOE

