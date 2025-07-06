extends Node

enum SkillReductionType {
	FLAT = 0,
	REMAINING_PERCENT = 1,
	PERCENT = 2
}

func damage(target, dealer, ammount):
	target.champion.stats.hp = max(0, target.champion.stats.hp - ammount)
	
	var dealerSig = Globals.find_node("Signalizer", dealer)
	var targetSig = Globals.find_node("Signalizer", target)
	
	dealerSig.damage_dealt.emit(target, ammount)
	targetSig.damage_recieved.emit(dealer, ammount)

func heal(target, dealer, ammount):
	target.champion.stats.hp = min(target.champion.stats.hp + ammount, target.champion.stats.getHpMax())
	
	var dealerSig = Globals.find_node("Signalizer", dealer)
	var targetSig = Globals.find_node("Signalizer", target)
	
	dealerSig.cure_dealt.emit(target, ammount)
	targetSig.cure_recieved.emit(dealer, ammount)

func mana_heal(target, dealer, ammount):
	target.champion.stats.mana = min(target.champion.stats.mana + ammount, target.champion.stats.getManaMax())
	
	var dealerSig = Globals.find_node("Signalizer", dealer)
	var targetSig = Globals.find_node("Signalizer", target)
	
	dealerSig.mana_dealt.emit(target, ammount)
	targetSig.mana_recieved.emit(dealer, ammount)

func reduce_cooldown(player, skill, ammount, ReductionType):
	var skillNode = Globals.find_node("Skills/"+skill, player)
	match(ReductionType):
		SkillReductionType.FLAT:
			skillNode.cooldown_remaining = max(0, skillNode.cooldown_remaining - ammount)
		SkillReductionType.REMAINING_PERCENT:
			skillNode.cooldown_remaining *= 1 - ammount
		SkillReductionType.PERCENT:
			skillNode.cooldown_remaining = max(0, skillNode.cooldown_remaining - skillNode.cooldown * ammount)
	
