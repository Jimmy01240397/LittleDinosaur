`ifndef DEFINE
`define DEFINE
	`define vgaTime 1
	`define dotTime 2500
	`define gameTime 416666

	`define screenwidth 640
	`define screenheight 480
	`define screenwidthnumlen 30
	`define screenheightnumlen 30

	
	
	`define imagecount 2
	`define imagewidth 80
	`define imageheight 40
	
	`define playerxPos 80
	`define playeryPos 340
	`define playerFloatingPos 260
	`define jumpDuration 2
	
	`define datacount 10
	
	`define datatypelen 4
	`define dataxlen 10
	`define dataylen 10
	`define datawidthlen 10
	`define dataheigthlen 10
	
	`define datatypestart 0
	`define dataxstart (`datatypestart+`datatypelen)
	`define dataystart (`dataxstart+`dataxlen)
	`define datawidthstart (`dataystart+`dataylen)
	`define dataheigthstart (`datawidthstart+`datawidthlen)
	`define datalen (`dataheigthstart+`dataheigthlen)
	
	`define scorelen 13

	// --- main function ---
	`define y_movemevt_per_frame 1
`endif