`ifndef DEFINE
`define DEFINE
	`define clockHz 50000000

	`define vgaHz 25000000
	`define dotHz 10000
	`define gameHz 60
	
	`define randomNUMlen 4
	`define randomCount 2
	
	`define screenwidth 640
	`define screenheight 480
	`define screenwidthnumlen 30
	`define screenheightnumlen 30

	`define nulltype 0
	`define titletype 1
	`define playertype 2
	`define enemytype 3
	
	`define imagecount 3
	`define imagewidth 80
	`define imageheight 40
	
	`define playerwidth 40
	`define playerheight 80
	`define playerxPos 80
	`define playeryPos (`screenheight - `playerheight - 80)
	`define playerFloatingPos (`playeryPos - 100)
	`define jumpDuration 1
	
	`define datacount 10
	
	`define datatypelen 4
	`define dataxlen 10
	`define dataylen 10
	`define datawidthlen 10
	`define dataheightlen 10
	
	`define datatypestart 0
	`define dataxstart (`datatypestart+`datatypelen)
	`define dataystart (`dataxstart+`dataxlen)
	`define datawidthstart (`dataystart+`dataylen)
	`define dataheightstart (`datawidthstart+`datawidthlen)
	`define datalen (`dataheightstart+`dataheightlen)
	
	`define scorelen 13
	`define scoreaddperiod 1

	`define enemymovementperframe 5
	`define enemywidthinit 40
	`define enemyheightinit 80
	`define enemyyPos `playeryPos
	
	`define titlewidth (`screenwidth - 100)
	`define titleheight (`screenheight - 100)
	`define titlexPos 50
	`define titleyPos 50
`endif
