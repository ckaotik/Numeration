local n = select(2, ...)

if GetLocale() == "ruRU" then
	n.locale = {
		dmg_tar = "Урон по целям",
		dmg_take_tar = "Полученный урон: Цели",
		dmg_take_abil = "Полученный урон: Способности",
		friend_fire = "Огонь по своим",
		heal_take_abil = "Полученное лечение: Способности",
		overheal = "Переисцеление",
		death_log = "Журнал смертей",
		tar = "по целям",
		sel_set = "Выбор режима",
		overall = "Все битвы",
		current = "Текущий бой",
		pet_merge = "Объединять питомца с хозяином",
		only_boss = "Хранить только бои с боссами",
		only_instance = "Запись только в подземельях",
		show_icon = "Иконка у миникарты",
		toggle = "ЛКМ, чтобы показать/скрыть окно.",
		reset = "Shift + ЛКМ, чтобы сбросить данные.",
		binding_visibility = "Переключение видимости",
		binding_reset = "Сброс данных",
		reset_data = "сбросить данные?",
		whisp_target = "шепнуть цели",
		bad_report = "Нет данных для отчета.",
		bad_whisp = "Нет цели или неправильная.",
		death = "Смерть",
		m = "м",
		s = "с",
		-- BossIDs
		fallen = "Павшие Защитники",
		noru = "Норусхен",
		gala = "Галакрас",
		shaman = "Темные Шаманы",
		spoil = "Пандарийские Трофеи",
		para = "Идеалы Клакси",
		elder = "Совет Старейшин",
		mega = "Мегера",
		anima = "Темный Анимус",
		twin = "Наложницы-близнецы",
		prot = "Стражи Бесконечности",
		stone = "Каменные стражи",
		kings = "Призрачные короли",
		will = "Воля Императора",
		trial = "Испытание короля",
		inq = "Верховный инквизитор Вайтмейн",
		lore = "Хранитель истории"
	}
elseif GetLocale() == "zhTW" then
	n.locale = {
		dmg_tar = "傷害目標",
		dmg_take_tar = "傷害承受: 目標",
		dmg_take_abil = "傷害承受: 技能",
		friend_fire = "隊友誤傷",
		heal_take_abil = "治療承受: 技能",
		overheal = "過量治療",
		death_log = "死亡記錄",
		tar = "目標",
		sel_set = "選擇: 設定",
		overall = "總體數據",
		current = "當前戰鬥",
		pet_merge = "合併寵物傷害",
		only_boss = "只保留BOSS數據",
		only_instance = "只在副本中统計",
		show_icon = "顯示小地圖圖示",
		toggle = "左鍵點擊隱藏/顯示窗口.",
		reset = "SHIFT+左鍵點擊重置數據.",
		binding_visibility = "切換可見",
		binding_reset = "重置數據",
		reset_data = "重置數據?",
		whisp_target = "密語目標",
		bad_report = "錯誤: 選擇報告類型.",
		bad_whisp = "選擇無效或沒有目標.",
		death = "死亡",
		m = "分",
		s = "秒",
		-- BossIDs
		fallen = "墮落的保衛者",
		noru = "諾努衫",
		gala = "葛拉卡斯",
		shaman = "柯爾克隆黑暗薩滿",
		spoil = "潘達利亞之寶",
		para = "卡拉西聖螳",
		elder = "長老議會",
		mega = "梅賈拉",
		anima = "黑暗憎惡魔像",
		twin = "弧慍雙妃",
		prot = "豐泉守衛者",
		stone = "石衛士",
		kings = "帝王之魂",
		will = "大帝之志",
		trial = "帝王的試煉",
		inq = "高階審判官懷特邁恩",
		lore = "博學行者石步"
	}
elseif GetLocale() == "deDE" then
	n.locale = {
		dmg_tar = "Schadens Ziele",
		dmg_take_tar = "Schaden an Zielen",
		dmg_take_abil = "Schaden mit Fähigkeiten",
		friend_fire = "Eigenbeschuss",
		heal_take_abil = "Heilung mit Fähigkeiten",
		overheal = "Überheilung",
		death_log = "Tode",
		tar = "Ziele",
		sel_set = "Auswahl: Set",
		overall = "Alle Daten",
		current = "Momentaner Kampf",
		pet_merge = "Tiere und Besitzer zusammen",
		only_boss = "Nur Bosskämpfe speichern",
		only_instance = "Nur in Instanzen aufzeichnen",
		show_icon = "Zeige Minimap Icon",
		toggle = "Links-Klick Fenster Zeigen/Verstechen.",
		reset = "Shift+Links-Klick um Daten zurückzusetzen.",
		binding_visibility = "Ansicht umschalten",
		binding_reset = "Daten Zurücksetzen",
		reset_data = "Daten Zurücksetzen?",
		whisp_target = "Ziel anflüstern",
		bad_report = "Error: wähle Art des Berichtes.",
		bad_whisp = "Ungültiges oder kein Ziel angewählt.",
		death = "Tod",
		m = "m",
		s = "s",
		-- BossIDs
		fallen = "Die gefallenen Beschützer",
		noru = "Norushen",
		gala = "Galakras",
		shaman = "Dunkelschamanen",
		spoil = "Die Schätze Pandarias",
		para = "Die Getreuen der Klaxxi",
		elder = "Rat der Ältesten",
		mega = "Megaera",
		anima = "Dunkler Animus",
		twin = "Zwillingskonkubinen",
		prot = "Beschützer der Endlosen",
		stone = "Die Steinwache",
		kings = "Die Geisterkönige",
		will = "Der Wille des Kaisers",
		trial = "Die Prüfung des Königs",
		inq = "Hochinquisitorin Weißsträhne",
		lore = "Lehrensucher Steinschritt"
	}
elseif GetLocale() == "koKR" then
	n.locale = {
		dmg_tar = "피해 대상",
		dmg_take_tar = "받은 피해: 대상별",
		dmg_take_abil = "받은 피해: 주문별",
		friend_fire = "아군 공격",
		heal_take_abil = "받은 치유: 주문별",
		overheal = "초과치유",
		death_log = "죽음 로그",
		tar = "대상",
		sel_set = "선택: 세트",
		overall = "전체 자료",
		current = "현재 전투",
		pet_merge = "소환수를 소환자에 합산",
		only_boss = "보스 전투만 유지",
		only_instance = "인스턴스만 기록",
		show_icon = "미니맵 아이콘 표시",
		toggle = "클릭 : 창 보이기/숨기기",
		reset = "시프트+클릭 : 자료 초기화",
		binding_visibility = "보이기/숨기기",
		binding_reset = "자료 초기화",
		reset_data = "자료를 초기화하겠습니까?",
		whisp_target = "귓속말을 받을 대상",
		bad_report = "오류: 보고할 유형을 선택하세요.",
		bad_whisp = "잘못되었거나 선택한 대상이 없습니다.",
		death = "죽음",
		m = "분",
		s = "초",
		-- BossIDs
		fallen = "쓰러진 수호자들",
		noru = "노루센",
		gala = "갈라크라스",
		shaman = "코르크론 암흑주술사",
		spoil = "판다리아의 전리품",
		para = "클락시 용장들",
		elder = "장로회",
		mega = "메가이라",
		anima = "암흑 원령",
		twin = "쌍둥이 왕비",
		prot = "영원의 수호병",
		stone = "바위 수호자",
		kings = "유령 왕",
		will = "황제의 의지",
		trial = "왕의 시험",
		inq = "종교재판관 하이트메인",
		lore = "전승지기 스톤스텝"
	}
else
	n.locale = {
		dmg_tar = "Damage Targets",
		dmg_take_tar = "Damage Taken: Targets",
		dmg_take_abil = "Damage Taken: Abilities",
		friend_fire = "Friendly Fire",
		heal_take_abil = "Healing Taken: Abilities",
		overheal = "Overhealing",
		death_log = "Death Log",
		tar = "Targets",
		sel_set = "Selection: Set",
		overall = "Overall Data",
		current = "Current Fight",
		pet_merge = "Merge Pets w/ Owners",
		only_boss = "Keep Only Boss Segments",
		only_instance = "Record Only In Instances",
		show_icon = "Show Minimap Icon",
		toggle = "Left-Click to toggle window visibility.",
		reset = "Shift + Left-Click to reset data.",
		binding_visibility = "Toggle Visibility",
		binding_reset = "Reset Data",
		reset_data = "Reset Data?",
		whisp_target = "Whisper target",
		bad_report = "There is nothing to report.",
		bad_whisp = "Invalid or no target selected.",
		death = "Death",
		m = "m",
		s = "s",
		-- BossIDs
		fallen = "The Fallen Protectors",
		noru = "Norushen",
		gala = "Galakras",
		shaman = "Kor'kron Dark Shaman",
		spoil = "Spoils of Pandaria",
		para = "Paragons of the Klaxxi",
		elder = "Council of Elders",
		mega = "Megaera",
		anima = "Dark Animus",
		twin = "Twin Consorts",
		prot = "Protectors of the Endless",
		stone = "Stone Guard",
		kings = "The Spirit Kings",
		will = "Will of the Emperor",
		trial = "Trial of the King",
		inq = "High Inquisitor Whitemane",
		lore = "Lorewalker Stonestep"
	}
end