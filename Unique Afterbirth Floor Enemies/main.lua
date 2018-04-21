UniqueAfterbirthFloorEnemiesMod = RegisterMod("Unique Afterbirth Floor Enemies", 1)

UniqueAfterbirthFloorSpritesets = {
	NONE = 0,
	FLAMING = 1,
	FLOODED = 2,
	DANK = 3,
	SCARRED = 4
}

function UniqueAfterbirthFloorEnemiesMod:getSpritesetsToUse()
	local level = Game():GetLevel()
	local currentStage = level:GetStage()
	local spritesetToUse = UniqueAfterbirthFloorSpritesets.NONE
	if not Game():IsGreedMode() then
		if currentStage == 12 then
			local room = level:GetCurrentRoom()
			local roomStage = room:GetRoomConfigStage()
			
			if roomStage == 3 then
				spritesetToUse = UniqueAfterbirthFloorSpritesets.FLAMING
			elseif roomStage == 6 then 
				spritesetToUse = UniqueAfterbirthFloorSpritesets.FLOODED
			elseif roomStage == 9 then
				spritesetToUse = UniqueAfterbirthFloorSpritesets.DANK
			elseif roomStage == 12 then
				spritesetToUse = UniqueAfterbirthFloorSpritesets.SCARRED
			end
		else
			local currentStageType = level:GetStageType()
			if currentStageType == 2 then
				if currentStage == 1 or currentStage == 2 then
					spritesetToUse = UniqueAfterbirthFloorSpritesets.FLAMING
				elseif currentStage == 3 or currentStage == 4 then
					spritesetToUse = UniqueAfterbirthFloorSpritesets.FLOODED
				elseif currentStage == 5 or currentStage == 6 then
					spritesetToUse = UniqueAfterbirthFloorSpritesets.DANK
				elseif currentStage == 7 or currentStage == 8 then
					spritesetToUse = UniqueAfterbirthFloorSpritesets.SCARRED
				end
			end
		end
	end
	
	return spritesetToUse
end

function UniqueAfterbirthFloorEnemiesMod:onRespritableEntityUpdate(entity, variant, subtype, layer, flamingSpritesheet, floodedSpritesheet, dankSpritesheet, scarredSpritesheet)
	local frameCount = entity.FrameCount
	if frameCount <= 1 then
		if variant == nil then
			variant = -1
		end
		if entity.Variant == variant or variant == -1 then
			if subtype == nil then
				subtype = -1
			end
			if entity.SubType == subtype or subtype == -1 then
				local spritesetToUse = UniqueAfterbirthFloorEnemiesMod:getSpritesetsToUse()
				if spritesetToUse ~= UniqueAfterbirthFloorSpritesets.NONE then
					local spritesheet = nil
					if spritesetToUse == UniqueAfterbirthFloorSpritesets.FLAMING then
						spritesheet = flamingSpritesheet
					elseif spritesetToUse == UniqueAfterbirthFloorSpritesets.FLOODED then
						spritesheet = floodedSpritesheet
					elseif spritesetToUse == UniqueAfterbirthFloorSpritesets.DANK then
						spritesheet = dankSpritesheet
					elseif spritesetToUse == UniqueAfterbirthFloorSpritesets.SCARRED then
						spritesheet = scarredSpritesheet
					end
					if spritesheet ~= nil then
						local sprite = entity:GetSprite()
						sprite:ReplaceSpritesheet(layer, spritesheet) 
						sprite:LoadGraphics()
					end
				end
			end
		end
	end
end

function UniqueAfterbirthFloorEnemiesMod:onGaperUpdate(entity)
	UniqueAfterbirthFloorEnemiesMod:onRespritableEntityUpdate(entity, 0, -1, 1, "gfx/monsters/flaming/singed_frowning_gaper.png", nil, nil, nil) --frowning
	UniqueAfterbirthFloorEnemiesMod:onRespritableEntityUpdate(entity, 1, -1, 1, "gfx/monsters/afterbirth/010.002_flaminggaper.png", nil, nil, nil) --regular
end
UniqueAfterbirthFloorEnemiesMod:AddCallback(ModCallbacks.MC_NPC_UPDATE, UniqueAfterbirthFloorEnemiesMod.onGaperUpdate, EntityType.ENTITY_GAPER)

function UniqueAfterbirthFloorEnemiesMod:onHorfUpdate(entity)
	UniqueAfterbirthFloorEnemiesMod:onRespritableEntityUpdate(entity, 0, -1, 0, "gfx/monsters/flaming/singed_horf.png", nil, nil, nil)
end
UniqueAfterbirthFloorEnemiesMod:AddCallback(ModCallbacks.MC_NPC_UPDATE, UniqueAfterbirthFloorEnemiesMod.onHorfUpdate, EntityType.ENTITY_HORF)

function UniqueAfterbirthFloorEnemiesMod:onCyclopiaUpdate(entity)
	UniqueAfterbirthFloorEnemiesMod:onRespritableEntityUpdate(entity, 0, -1, 1, "gfx/monsters/flaming/singed_cyclopia.png", nil, nil, nil)
end
UniqueAfterbirthFloorEnemiesMod:AddCallback(ModCallbacks.MC_NPC_UPDATE, UniqueAfterbirthFloorEnemiesMod.onCyclopiaUpdate, EntityType.ENTITY_CYCLOPIA)

function UniqueAfterbirthFloorEnemiesMod:onFattyUpdate(entity)
	UniqueAfterbirthFloorEnemiesMod:onRespritableEntityUpdate(entity, 0, -1, 0, "gfx/monsters/afterbirth/207.002_flamingfatty.png", nil, nil, nil) --regular
	UniqueAfterbirthFloorEnemiesMod:onRespritableEntityUpdate(entity, 0, -1, 1, "gfx/monsters/afterbirth/207.002_flamingfatty.png", nil, nil, nil)
end
UniqueAfterbirthFloorEnemiesMod:AddCallback(ModCallbacks.MC_NPC_UPDATE, UniqueAfterbirthFloorEnemiesMod.onFattyUpdate, EntityType.ENTITY_FATTY)