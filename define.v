`ifndef DEFINE
`define DEFINE
	`define clockHz 50000000

	`define vgaHz 25000000
	`define dotHz 10000
	`define gameHz 60
	
	`define screenwidth 640
	`define screenheight 480
	`define screenwidthnumlen 30
	`define screenheightnumlen 30

	`define playertype 1
	`define enemytype 2
	
	`define imagecount 2
	`define imagewidth 80
	`define imageheight 40
	
	`define playerwidth 40
	`define playerheight 80
	`define playerxPos 80
	`define playeryPos (`screenwidth - `playerheight - 80)
	`define playerFloatingPos (`playeryPos - 100)
	`define jumpDuration 2
	
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

	// --- main function ---
	`define y_movemevt_per_frame 1
`endif