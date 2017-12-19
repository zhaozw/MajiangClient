local GameLogic = {}

local cmd = appdf.req(appdf.GAME_SRC.."yule.sparrowchy.src.models.CMD_Game")

--牌库数目
GameLogic.FULL_COUNT				= 136
GameLogic.MAGIC_DATA 				= 0xff -- 53
GameLogic.MAGIC_INDEX 				= 32
GameLogic.NORMAL_DATA_MAX 			= 0x29 -- 41
GameLogic.NORMAL_INDEX_MAX 			= 27

--显示类型
GameLogic.SHOW_NULL					= 0							--无操作
GameLogic.SHOW_CHI 					= 1 						--吃
GameLogic.SHOW_PENG					= 2 						--碰
GameLogic.SHOW_BU_GANG			    = 3							--补杠（碰后再杠）
GameLogic.SHOW_MING_GANG			= 4							--明杠
GameLogic.SHOW_AN_GANG				= 5							--暗杠

GameLogic.SHOW_FENG_GANG            = 6
GameLogic.SHOW_CHANGMAO_GANG        = 7


--动作标志
GameLogic.WIK_NULL					= 0x0000						--没有类型--0
GameLogic.WIK_LEFT					= 0x0001						--左吃类型--1
GameLogic.WIK_CENTER				= 0x0002						--中吃类型--2
GameLogic.WIK_RIGHT					= 0x0004						--右吃类型--4
GameLogic.WIK_PENG					= 0x0008						--碰牌类型--8
GameLogic.WIK_GANG					= 0x0010						--杠牌类型--16
GameLogic.WIK_LISTEN				= 0x0020						--听牌类型--32
GameLogic.WIK_CHI_HU				= 0x0040						--吃胡类型--64
GameLogic.WIK_FANG_PAO				= 0x0080						--放炮--128
--朝阳麻将 Additional Flag
GameLogic.WIK_ARROW					= 0x0100						--【中发白】三张【箭牌】在一起组成的杠 --256
GameLogic.WIK_WIND					= 0x0200						--【东南西北】四张【风牌】在一起组成的杠 --512
GameLogic.WIK_CHASEARROW			= 0x0400						--【中发白】的杠追加【中发白】牌后的杠 --1024
GameLogic.WIK_CHASEWIND				= 0x0800						--【东南西北】的杠追加风牌后的杠 --2048
GameLogic.WIK_FEN_ZHANG				= 0x4000                        -- 分张 -- 16384
GameLogic.WIK_UPDATE_BAO			= 0x8000						-- 换宝  --32768

--CMD_S_GameConclude.wHuKindData 
GameLogic.HU_KIND_MASK				= 0x0000FFFF
GameLogic.CHR_PING_HU				= 0x00000001			-- 平胡
GameLogic.CHR_ZHUANG_JIA			= 0x00000002			-- 庄家
GameLogic.CHR_ZI_MO					= 0x00000004			-- 自摸
GameLogic.CHR_QING_YI_SE			= 0x00000008			-- 清一色
GameLogic.CHR_PIAO_HU				= 0x00000010		    -- 飘胡     // =0
GameLogic.CHR_QIONG_HU				= 0x00000020			-- 穷胡     // =0
GameLogic.CHR_SHI_SAN_YAO			= 0x00000040			-- 十三幺
GameLogic.CHR_QI_DUI				= 0x00000080			-- 七对		// =0
GameLogic.CHR_SHOU_BA_YI			= 0x00000100			-- 手把一	
GameLogic.CHR_JIA_HU				= 0x00000200			--	夹胡
GameLogic.CHR_JIN_BAO				= 0x00000800			-- 进宝
GameLogic.CHR_FEN_ZHANG				= 0x00008000			-- 分张	// 海底捞月（haidilaoyue）

GameLogic.CHR_GANG_SHANG_HUA        = 0x00010000          -- 杠上花
GameLogic.CHR_GANG_SHANG_PAO        = 0x00020000          -- 杠上炮
GameLogic.CHR_QIANG_GANG_HU         = 0x00040000          -- 抢杠胡
GameLogic.CHR_QI_YU					= 0x00080000			-- 其余三家闭门
GameLogic.CHR_CHI_HU				= 0x00100000			-- 放炮

--动作类型
GameLogic.WIK_GANERAL				= 0x00						--普通操作
GameLogic.WIK_BU_GANG				= 0x01						--补杠（碰后再杠）
GameLogic.WIK_MING_GANG				= 0x02						--明杠
GameLogic.WIK_AN_GANG				= 0x03						--暗杠

GameLogic.LocalCardData = 
{
	0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09,
	0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18, 0x19,
	0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, 0x28, 0x29,
	0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37
}

GameLogic.TotalCardData = 
{
	0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09,
	0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09,
	0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09,
	0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09,
	0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18, 0x19,
	0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18, 0x19,
	0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18, 0x19,
	0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18, 0x19,
	0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, 0x28, 0x29,
	0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, 0x28, 0x29,
	0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, 0x28, 0x29,
	0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, 0x28, 0x29,
    0x31, 0x31, 0x31, 0x31,
    0x32, 0x32, 0x32, 0x32,
    0x33, 0x33, 0x33, 0x33,
    0x34, 0x34, 0x34, 0x34,
    0x35, 0x35, 0x35, 0x35,
    0x36, 0x36, 0x36, 0x36,
    0x37, 0x37, 0x37, 0x37,
}

function GameLogic.SwitchToCardIndex(card)
	local index = 0
	for i = 1, #GameLogic.LocalCardData do
		if GameLogic.LocalCardData[i] == card then
			index = i
			break
		end
	end
	local strError = string.format("The card %d is error!", card)
	assert(index ~= 0, strError)
	return index
end

function GameLogic.SwitchToCardData(index)
	assert(index >= 1 and index <= 34, "The card index is error!")
	return GameLogic.LocalCardData[index]
end

function GameLogic.DataToCardIndex(cbCardData)
	assert(type(cbCardData) == "table")
	--初始化
	local cbCardIndex = {}
	for i = 1, 34 do
		cbCardIndex[i] = 0
	end
	--累加
	for i = 1, #cbCardData do
		local bCardExist = false
		for j = 1, 34 do
			if cbCardData[i] == GameLogic.LocalCardData[j] then
				cbCardIndex[j] = cbCardIndex[j] + 1
				bCardExist = true
			end
		end
		assert(bCardExist, "This card is not exist!")
	end

	return cbCardIndex
end

--删除扑克
function GameLogic.RemoveCard(cbCardData, cbRemoveCard)
	assert(type(cbCardData) == "table" and type(cbRemoveCard) == "table")
	local cbCardCount, cbRemoveCount = #cbCardData, #cbRemoveCard
	assert(cbRemoveCount <= cbCardCount)

	--置零扑克
	for i = 1, cbRemoveCount do
		for j = 1, cbCardCount do
			if cbRemoveCard[i] == cbCardData[j] then
				cbCardData[j] = 0
				break
			end
		end
	end
	--清理扑克
	local resultData = {}
	local cbCardPos = 1
	for i = 1, cbCardCount do
		if cbCardData[i] ~= 0 then
			resultData[cbCardPos] = cbCardData[i]
			cbCardPos = cbCardPos + 1
		end
	end

	return resultData
end

--混乱扑克
function GameLogic.RandCardList(cbCardData)
	assert(type(cbCardData) == "table")
	--混乱准备
	local cbCardCount = #cbCardData
	local cbCardTemp = clone(cbCardData)
	local cbCardBuffer = {}
	--开始
	local cbRandCount, cbPosition = 0, 0
	while cbRandCount < cbCardCount do
		cbPosition = math.random(cbCardCount - cbRandCount)
		cbCardBuffer[cbRandCount + 1] = cbCardTemp[cbPosition]
		cbCardTemp[cbPosition] = cbCardTemp[cbCardCount - cbRandCount]
		cbRandCount = cbRandCount + 1
	end
	return cbCardBuffer
end

--排序
function GameLogic.SortCardList(cbCardData)
	--校验
	assert(type(cbCardData) == "table" and #cbCardData > 0)
	local cbCardCount = #cbCardData
	--排序操作
	local bSorted = false
	local cbLast = cbCardCount - 1
	while bSorted == false do
		bSorted = true
		for i = 1, cbLast do
			if cbCardData[i] > cbCardData[i + 1] then
				bSorted = false
				cbCardData[i], cbCardData[i + 1] = cbCardData[i + 1], cbCardData[i]
			end
		end
		cbLast = cbLast - 1
	end
end

--分析打哪一张牌后听哪张牌
function GameLogic.AnalyseListenCard(cbCardData)
	assert(type(cbCardData) == "table")
	local cbCardCount = #cbCardData
	assert(math.mod(cbCardCount - 2, 3) == 0)

	local cbListenList = {}
	local cbListenData = {cbOutCard = 0, cbListenCard = {}}
	local tempCard = 0
	local bWin = false
	for i = 1, cbCardCount do
		if tempCard ~= cbCardData[i] then		--过滤重复牌
			cbListenData.cbOutCard = cbCardData[i]
			cbListenData.cbListenCard = {}
			local cbTempData = clone(cbCardData)
			--table.remove(cbTempData, i)
			for j = 1, GameLogic.NORMAL_INDEX_MAX do
				local localCard = GameLogic.LocalCardData[j]
				local insertData = clone(cbTempData)
				--table.insert(insertData, GameLogic.LocalCardData[j])
				insertData[i] = localCard
				GameLogic.SortCardList(insertData)
				if GameLogic.AnalyseChiHuCard(insertData, true) then
					table.insert(cbListenData.cbListenCard, localCard)
					if cbCardData[i] == GameLogic.LocalCardData[j] then
						bWin = true --胡牌
						break
					end
				end
			end
			if #cbListenData.cbListenCard > 0 then
				table.insert(cbListenList, cbListenData)
				--print("听牌")
			end

			if bWin then
				break
			end
		end
		tempCard = cbCardData[i]
	end
	return cbListenList, bWin
end

--分析是否胡牌(带朝阳)
function GameLogic.AnalyseChiHuCard(cbCardData, bNoneThePair)
	local cbCardCount = #cbCardData
	--朝阳统计
	local cbCardIndex = GameLogic.DataToCardIndex(cbCardData)
	local cbMagicCardCount = cbCardIndex[GameLogic.MAGIC_INDEX]
	--成功，全部合格
	if cbCardCount == 0 then
		--print("这个时候已经算胡了！")
		return true
	end
	local cbRemoveData = {0, 0, 0}
	--三张相同
	if cbCardData[1] == cbCardData[2] and
	cbCardData[1] == cbCardData[3] then
		--print("三张相同")
		bThree = true
		cbRemoveData[1] = cbCardData[1]
		cbRemoveData[2] = cbCardData[2]
		cbRemoveData[3] = cbCardData[3]
		local cbTempData = GameLogic.RemoveCard(clone(cbCardData), cbRemoveData)
		if GameLogic.AnalyseChiHuCard(cbTempData, bNoneThePair) then 		--递归
			return true
		end
	end
	--三张相连
	local index = GameLogic.SwitchToCardIndex(cbCardData[1])
	if math.mod(index, 9) + 2 <= 9 and
	cbCardIndex[index + 1] ~= 0 and
	cbCardIndex[index + 2] ~= 0 then
		--print("三张相连")
		cbRemoveData[1] = cbCardData[1]
		cbRemoveData[2] = GameLogic.SwitchToCardData(index + 1)
		cbRemoveData[3] = GameLogic.SwitchToCardData(index + 2)
		local cbTempData = GameLogic.RemoveCard(clone(cbCardData), cbRemoveData)
		if GameLogic.AnalyseChiHuCard(cbTempData, bNoneThePair) then 		--递归
			return true
		end
	end
	--两张相同组成一对将（不使用朝阳代替）
	if cbCardData[1] == cbCardData[2] and bNoneThePair then
		--print("两张相同组成一对将（不使用朝阳代替）")
		bNoneThePair = false
		cbRemoveData[1] = cbCardData[1]
		cbRemoveData[2] = cbCardData[2]
		cbRemoveData[3] = 0
		local cbTempData = GameLogic.RemoveCard(clone(cbCardData), cbRemoveData)
		if GameLogic.AnalyseChiHuCard(cbTempData, bNoneThePair) then 		--递归
			return true
		end
	end
	--有朝阳时使用朝阳代替
	if cbMagicCardCount > 0 then
		--两张相同
		if cbCardData[1] == cbCardData[2] then
			--print("两张相同")
			cbRemoveData[1] = cbCardData[1]
			cbRemoveData[2] = cbCardData[2]
			cbRemoveData[3] = GameLogic.MAGIC_DATA
			local cbTempData = GameLogic.RemoveCard(clone(cbCardData), cbRemoveData)
			if GameLogic.AnalyseChiHuCard(cbTempData, bNoneThePair) then 		--递归
				return true
			end
		end
		--两张相邻
		if cbCardData[1] + 1 == cbCardData[2] then
			--print("两张相邻")
			cbRemoveData[1] = cbCardData[1]
			cbRemoveData[2] = cbCardData[2]
			cbRemoveData[3] = GameLogic.MAGIC_DATA
			local cbTempData = GameLogic.RemoveCard(clone(cbCardData), cbRemoveData)
			if GameLogic.AnalyseChiHuCard(cbTempData, bNoneThePair) then 		--递归
				return true
			end
		end
		--两张相隔
		if cbCardData[1] + 2 == cbCardData[2] then
			--print("两张相隔")
			cbRemoveData[1] = cbCardData[1]
			cbRemoveData[2] = cbCardData[2]
			cbRemoveData[3] = GameLogic.MAGIC_DATA
			local cbTempData = GameLogic.RemoveCard(clone(cbCardData), cbRemoveData)
			if GameLogic.AnalyseChiHuCard(cbTempData, bNoneThePair) then 		--递归
				return true
			end
		end
		--一张组成一对将
		if bNoneThePair then
			--print("一张组成一对将")
			bNoneThePair = false
			local cbRemoveData = {cbCardData[1], }
			cbRemoveData[1] = cbCardData[1]
			cbRemoveData[2] = GameLogic.MAGIC_DATA
			cbRemoveData[3] = 0
			local cbTempData = GameLogic.RemoveCard(clone(cbCardData), cbRemoveData)
			if GameLogic.AnalyseChiHuCard(cbTempData, bNoneThePair) then 		--递归
				return true
			end
		end
	end

	return false
end

--胡牌分析(在不考虑红中的情况下)
function GameLogic.AnalyseHuPai(cbCardData)
	--校验
	assert(type(cbCardData) == "table")
	local cbCardCount = #cbCardData
	assert(math.mod(cbCardCount - 2, 3) == 0)
	--成功，剩一对酱
	if cbCardCount == 2 and cbCardData[1] == cbCardData[2] then
		--print("这个时候已经算胡了")
		return true
	end
	--转换成牌下标
	local cbCardIndex = GameLogic.DataToCardIndex(cbCardData)
	--遍历
	for i = 1, cbCardCount - 2 do
		--三张相同
		if cbCardData[i] == cbCardData[i + 1] and
		cbCardData[i] == cbCardData[i + 2] then
			--print("三张相同")
			local cbRemoveData = {cbCardData[i], cbCardData[i + 1], cbCardData[i + 2]}
			local cbTempData = GameLogic.RemoveCard(clone(cbCardData), cbRemoveData)
			if GameLogic.AnalyseHuPai(cbTempData) then 		--递归
				return true
			end
		end
		--三张相连
		local index = GameLogic.SwitchToCardIndex(cbCardData[i])
		if math.mod(index, 9) + 2 <= 9 and
		cbCardIndex[index + 1] ~= 0 and
		cbCardIndex[index + 2] ~= 0 then
			--print("三张相连")
			local data1 = GameLogic.SwitchToCardData(index + 1)
			local data2 = GameLogic.SwitchToCardData(index + 2)
			local cbRemoveData = {cbCardData[i], data1, data2}
			local cbTempData = GameLogic.RemoveCard(clone(cbCardData), cbRemoveData)
			if GameLogic.AnalyseHuPai(cbTempData) then 		--递归
				return true
			end
		end
		--也不是一对将
		if cbCardData[i] ~= cbCardData[i + 1] and cbCardData[i] ~= cbCardData[i - 1] then
			--print("这样走不通")
			return false
		end
	end

	return false
end

--临近牌统计
function GameLogic.NearCardGether(cbCardData)
	assert(type(cbCardData) == "table")

	local nearCardData = {}
	for i = 1, #cbCardData do
		assert(cbCardData[i] ~= GameLogic.MAGIC_DATA)
		for j = cbCardData[i] - 1, cbCardData[i] + 1 do
			local num = math.mod(j, 16)
			if num >= 1 and num <= 9 then
				table.insert(nearCardData, j)
			end
		end
	end

	return GameLogic.RemoveRepetition(nearCardData)
end

--去除重复元素
function GameLogic.RemoveRepetition(cbCardData)
	assert(type(cbCardData) == "table")

	local bExist = {}
	for v, k in pairs(cbCardData) do
		bExist[k] = true
	end

	local result = {}
	for v, k in pairs(bExist) do
		table.insert(result, v)
	end

	GameLogic.SortCardList(result)

	return result
end

return GameLogic