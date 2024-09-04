module gameOfLifeUpdated (RedPixels, GrnPixels, leftButton, rightButton, downButton, upButton, confirmSeedSwitch, startGameSwitch, clk, reset);
	input logic leftButton, rightButton, downButton, upButton, confirmSeedSwitch, startGameSwitch, clk, reset;
	output logic [15:0][15:0] RedPixels;
	output logic [15:0][15:0] GrnPixels;
	
	
	
	
	// pass four DE1_SoC button inputs through two series DFFs to avoid metastability with fast user inputs
	logic firstRightInputSignal, secondRightInputSignal;
	basic_D_FF rightInputFirst (.q(firstRightInputSignal), .d(rightButton), .clk);
	basic_D_FF rightInputSecond (.q(secondRightInputSignal), .d(firstRightInputSignal), .clk);
	
	logic firstLeftInputSignal, secondLeftInputSignal;
	basic_D_FF leftInputFirst (.q(firstLeftInputSignal), .d(leftButton), .clk);
	basic_D_FF leftInputSecond (.q(secondLeftInputSignal), .d(firstLeftInputSignal), .clk);
	
	logic firstDownInputSignal, secondDownInputSignal;
	basic_D_FF downInputFirst (.q(firstDownInputSignal), .d(downButton), .clk);
	basic_D_FF downInputSecond (.q(secondDownInputSignal), .d(firstDownInputSignal), .clk);
	
	logic firstUpInputSignal, secondUpInputSignal;
	basic_D_FF upInputFirst (.q(firstUpInputSignal), .d(upButton), .clk);
	basic_D_FF upInputSecond (.q(secondUpInputSignal), .d(firstUpInputSignal), .clk);
	
	
	// pass four outputs of series DFF's through buttonInputFSM so that a move on the LED array is only registered after the button is pressed AND THEN released. 
	logic right, left, down, up;
	buttonPressFSM rightInputFinal (.out(right), .buttonPressed(secondRightInputSignal), .clk, .reset);
	buttonPressFSM leftInputFinal (.out(left), .buttonPressed(secondLeftInputSignal), .clk, .reset);
	buttonPressFSM downInputFinal (.out(down), .buttonPressed(secondDownInputSignal), .clk, .reset);
	buttonPressFSM upInputFinal (.out(up), .buttonPressed(secondUpInputSignal), .clk, .reset);
	
	
	// only want confirmSeedSwitch input to be true after it is switched on AND THEN off again
	logic confirmSeedSwitchSignal;
	buttonPressFSM confirmSwitchInputFinal (.out(confirmSeedSwitchSignal), .buttonPressed(confirmSeedSwitch), .clk, .reset);
	
	
	
	
	logic rowZeroColFifteenConfirmed;
	redSelectingLightFSM rowZeroColFifteenFirst (.redLED(RedPixels[0][15]), .l(RedPixels[0][8]), .a(RedPixels[7][15]), .r(RedPixels[0][14]), .b(RedPixels[1][15]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .startGameSwitch, .clk, .reset);
	selectingLightConfirmedFSM rowZeroColFifteenSecond (.selectingLightConfirmed(rowZeroColFifteenConfirmed), .l(RedPixels[0][8]), .a(RedPixels[7][15]), .r(RedPixels[0][14]), .b(RedPixels[1][15]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .confirmSeedSwitch(confirmSeedSwitchSignal), .startGameSwitch, .clk, .reset);
	greenSeedLightFSM rowZeroColFifteenThird (.greenLED(GrnPixels[0][15]), .gl(GrnPixels[0][8]), .gla(GrnPixels[7][8]), .ga(GrnPixels[7][15]), .gra(GrnPixels[7][14]), .gr(GrnPixels[0][14]), .grb(GrnPixels[1][14]), .gb(GrnPixels[1][15]), .glb(GrnPixels[1][8]), .selectingLightConfirmed(rowZeroColFifteenConfirmed), .startGameSwitch, .clk, .reset);
	
	
	logic rowZeroColFourteenConfirmed;
	redSelectingLightFSM rowZeroColFourteenFirst (.redLED(RedPixels[0][14]), .l(RedPixels[0][15]), .a(RedPixels[7][14]), .r(RedPixels[0][13]), .b(RedPixels[1][14]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .startGameSwitch, .clk, .reset);
	selectingLightConfirmedFSM rowZeroColFourteenSecond (.selectingLightConfirmed(rowZeroColFourteenConfirmed), .l(RedPixels[0][15]), .a(RedPixels[7][14]), .r(RedPixels[0][13]), .b(RedPixels[1][14]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .confirmSeedSwitch(confirmSeedSwitchSignal), .startGameSwitch, .clk, .reset);
	greenSeedLightFSM rowZeroColFourteenThird (.greenLED(GrnPixels[0][14]), .gl(GrnPixels[0][15]), .gla(GrnPixels[7][15]), .ga(GrnPixels[7][14]), .gra(GrnPixels[7][13]), .gr(GrnPixels[0][13]), .grb(GrnPixels[1][13]), .gb(GrnPixels[1][14]), .glb(GrnPixels[1][15]), .selectingLightConfirmed(rowZeroColFourteenConfirmed), .startGameSwitch, .clk, .reset);
	
	
	logic rowZeroColThirteenConfirmed;
	redSelectingLightFSM rowZeroColThirteenFirst (.redLED(RedPixels[0][13]), .l(RedPixels[0][14]), .a(RedPixels[7][13]), .r(RedPixels[0][12]), .b(RedPixels[1][13]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .startGameSwitch, .clk, .reset);
	selectingLightConfirmedFSM rowZeroColThirteenSecond (.selectingLightConfirmed(rowZeroColThirteenConfirmed), .l(RedPixels[0][14]), .a(RedPixels[7][13]), .r(RedPixels[0][12]), .b(RedPixels[1][13]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .confirmSeedSwitch(confirmSeedSwitchSignal), .startGameSwitch, .clk, .reset);
	greenSeedLightFSM rowZeroColThirteenThird (.greenLED(GrnPixels[0][13]), .gl(GrnPixels[0][14]), .gla(GrnPixels[7][14]), .ga(GrnPixels[7][13]), .gra(GrnPixels[7][12]), .gr(GrnPixels[0][12]), .grb(GrnPixels[1][12]), .gb(GrnPixels[1][13]), .glb(GrnPixels[1][14]), .selectingLightConfirmed(rowZeroColThirteenConfirmed), .startGameSwitch, .clk, .reset);
	
	
	logic rowZeroColTwelveConfirmed;
	redSelectingLightFSM rowZeroColTwelveFirst (.redLED(RedPixels[0][12]), .l(RedPixels[0][13]), .a(RedPixels[7][12]), .r(RedPixels[0][11]), .b(RedPixels[1][12]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .startGameSwitch, .clk, .reset);
	selectingLightConfirmedFSM rowZeroColTwelveSecond (.selectingLightConfirmed(rowZeroColTwelveConfirmed), .l(RedPixels[0][13]), .a(RedPixels[7][12]), .r(RedPixels[0][11]), .b(RedPixels[1][12]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .confirmSeedSwitch(confirmSeedSwitchSignal), .startGameSwitch, .clk, .reset);
	greenSeedLightFSM rowZeroColTwelveThird (.greenLED(GrnPixels[0][12]), .gl(GrnPixels[0][13]), .gla(GrnPixels[7][13]), .ga(GrnPixels[7][12]), .gra(GrnPixels[7][11]), .gr(GrnPixels[0][11]), .grb(GrnPixels[1][11]), .gb(GrnPixels[1][12]), .glb(GrnPixels[1][13]), .selectingLightConfirmed(rowZeroColTwelveConfirmed), .startGameSwitch, .clk, .reset);
	
	
	logic rowZeroColElevenConfirmed;
	redSelectingLightFSM rowZeroColElevenFirst (.redLED(RedPixels[0][11]), .l(RedPixels[0][12]), .a(RedPixels[7][11]), .r(RedPixels[0][10]), .b(RedPixels[1][11]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .startGameSwitch, .clk, .reset);
	selectingLightConfirmedFSM rowZeroColElevenSecond (.selectingLightConfirmed(rowZeroColElevenConfirmed), .l(RedPixels[0][12]), .a(RedPixels[7][11]), .r(RedPixels[0][10]), .b(RedPixels[1][11]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .confirmSeedSwitch(confirmSeedSwitchSignal), .startGameSwitch, .clk, .reset);
	greenSeedLightFSM rowZeroColElevenThird (.greenLED(GrnPixels[0][11]), .gl(GrnPixels[0][12]), .gla(GrnPixels[7][12]), .ga(GrnPixels[7][11]), .gra(GrnPixels[7][10]), .gr(GrnPixels[0][10]), .grb(GrnPixels[1][10]), .gb(GrnPixels[1][11]), .glb(GrnPixels[1][12]), .selectingLightConfirmed(rowZeroColElevenConfirmed), .startGameSwitch, .clk, .reset);
	
	
	logic rowZeroColTenConfirmed;
	redSelectingLightFSM rowZeroColTenFirst (.redLED(RedPixels[0][10]), .l(RedPixels[0][11]), .a(RedPixels[7][10]), .r(RedPixels[0][9]), .b(RedPixels[1][10]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .startGameSwitch, .clk, .reset);
	selectingLightConfirmedFSM rowZeroColTenSecond (.selectingLightConfirmed(rowZeroColTenConfirmed), .l(RedPixels[0][11]), .a(RedPixels[7][10]), .r(RedPixels[0][9]), .b(RedPixels[1][10]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .confirmSeedSwitch(confirmSeedSwitchSignal), .startGameSwitch, .clk, .reset);
	greenSeedLightFSM rowZeroColTenThird (.greenLED(GrnPixels[0][10]), .gl(GrnPixels[0][11]), .gla(GrnPixels[7][11]), .ga(GrnPixels[7][10]), .gra(GrnPixels[7][9]), .gr(GrnPixels[0][9]), .grb(GrnPixels[1][9]), .gb(GrnPixels[1][10]), .glb(GrnPixels[1][11]), .selectingLightConfirmed(rowZeroColTenConfirmed), .startGameSwitch, .clk, .reset);
	
	
	logic rowZeroColNineConfirmed;
	redSelectingLightFSM rowZeroColNineFirst (.redLED(RedPixels[0][9]), .l(RedPixels[0][10]), .a(RedPixels[7][9]), .r(RedPixels[0][8]), .b(RedPixels[1][9]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .startGameSwitch, .clk, .reset);
	selectingLightConfirmedFSM rowZeroColNineSecond (.selectingLightConfirmed(rowZeroColNineConfirmed), .l(RedPixels[0][10]), .a(RedPixels[7][9]), .r(RedPixels[0][8]), .b(RedPixels[1][9]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .confirmSeedSwitch(confirmSeedSwitchSignal), .startGameSwitch, .clk, .reset);
	greenSeedLightFSM rowZeroColNineThird (.greenLED(GrnPixels[0][9]), .gl(GrnPixels[0][10]), .gla(GrnPixels[7][10]), .ga(GrnPixels[7][9]), .gra(GrnPixels[7][8]), .gr(GrnPixels[0][8]), .grb(GrnPixels[1][8]), .gb(GrnPixels[1][9]), .glb(GrnPixels[1][10]), .selectingLightConfirmed(rowZeroColNineConfirmed), .startGameSwitch, .clk, .reset);
	
	
	logic rowZeroColEightConfirmed;
	redSelectingLightFSM rowZeroColEightFirst (.redLED(RedPixels[0][8]), .l(RedPixels[0][9]), .a(RedPixels[7][8]), .r(RedPixels[0][15]), .b(RedPixels[1][8]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .startGameSwitch, .clk, .reset);
	selectingLightConfirmedFSM rowZeroColEightSecond (.selectingLightConfirmed(rowZeroColEightConfirmed), .l(RedPixels[0][9]), .a(RedPixels[7][8]), .r(RedPixels[0][15]), .b(RedPixels[1][8]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .confirmSeedSwitch(confirmSeedSwitchSignal), .startGameSwitch, .clk, .reset);
	greenSeedLightFSM rowZeroColEightThird (.greenLED(GrnPixels[0][8]), .gl(GrnPixels[0][9]), .gla(GrnPixels[7][9]), .ga(GrnPixels[7][8]), .gra(GrnPixels[7][15]), .gr(GrnPixels[0][15]), .grb(GrnPixels[1][15]), .gb(GrnPixels[1][8]), .glb(GrnPixels[1][9]), .selectingLightConfirmed(rowZeroColEightConfirmed), .startGameSwitch, .clk, .reset);
	
	
	/* GAP BETWEEN ROW ZERO AND ROW ONE */
	
	
	logic rowOneColFifteenConfirmed;
	redSelectingLightFSM rowOneColFifteenFirst (.redLED(RedPixels[1][15]), .l(RedPixels[1][8]), .a(RedPixels[0][15]), .r(RedPixels[1][14]), .b(RedPixels[2][15]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .startGameSwitch, .clk, .reset);
	selectingLightConfirmedFSM rowOneColFifteenSecond (.selectingLightConfirmed(rowOneColFifteenConfirmed), .l(RedPixels[1][8]), .a(RedPixels[0][15]), .r(RedPixels[1][14]), .b(RedPixels[2][15]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .confirmSeedSwitch(confirmSeedSwitchSignal), .startGameSwitch, .clk, .reset);
	greenSeedLightFSM rowOneColFifteenThird (.greenLED(GrnPixels[1][15]), .gl(GrnPixels[1][8]), .gla(GrnPixels[0][8]), .ga(GrnPixels[0][15]), .gra(GrnPixels[0][14]), .gr(GrnPixels[1][14]), .grb(GrnPixels[2][14]), .gb(GrnPixels[2][15]), .glb(GrnPixels[2][8]), .selectingLightConfirmed(rowOneColFifteenConfirmed), .startGameSwitch, .clk, .reset);
	
	
	logic rowOneColFourteenConfirmed;
	redSelectingLightFSM rowOneColFourteenFirst (.redLED(RedPixels[1][14]), .l(RedPixels[1][15]), .a(RedPixels[0][14]), .r(RedPixels[1][13]), .b(RedPixels[2][14]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .startGameSwitch, .clk, .reset);
	selectingLightConfirmedFSM rowOneColFourteenSecond (.selectingLightConfirmed(rowOneColFourteenConfirmed), .l(RedPixels[1][15]), .a(RedPixels[0][14]), .r(RedPixels[1][13]), .b(RedPixels[2][14]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .confirmSeedSwitch(confirmSeedSwitchSignal), .startGameSwitch, .clk, .reset);
	greenSeedLightFSM rowOneColFourteenThird (.greenLED(GrnPixels[1][14]), .gl(GrnPixels[1][15]), .gla(GrnPixels[0][15]), .ga(GrnPixels[0][14]), .gra(GrnPixels[0][13]), .gr(GrnPixels[1][13]), .grb(GrnPixels[2][13]), .gb(GrnPixels[2][14]), .glb(GrnPixels[2][15]), .selectingLightConfirmed(rowOneColFourteenConfirmed), .startGameSwitch, .clk, .reset);
	
	
	logic rowOneColThirteenConfirmed;
	redSelectingLightFSM rowOneColThirteenFirst (.redLED(RedPixels[1][13]), .l(RedPixels[1][14]), .a(RedPixels[0][13]), .r(RedPixels[1][12]), .b(RedPixels[2][13]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .startGameSwitch, .clk, .reset);
	selectingLightConfirmedFSM rowOneColThirteenSecond (.selectingLightConfirmed(rowOneColThirteenConfirmed), .l(RedPixels[1][14]), .a(RedPixels[0][13]), .r(RedPixels[1][12]), .b(RedPixels[2][13]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .confirmSeedSwitch(confirmSeedSwitchSignal), .startGameSwitch, .clk, .reset);
	greenSeedLightFSM rowOneColThirteenThird (.greenLED(GrnPixels[1][13]), .gl(GrnPixels[1][14]), .gla(GrnPixels[0][14]), .ga(GrnPixels[0][13]), .gra(GrnPixels[0][12]), .gr(GrnPixels[1][12]), .grb(GrnPixels[2][12]), .gb(GrnPixels[2][13]), .glb(GrnPixels[2][14]), .selectingLightConfirmed(rowOneColThirteenConfirmed), .startGameSwitch, .clk, .reset);
	
	
	logic rowOneColTwelveConfirmed;
	redSelectingLightFSM rowOneColTwelveFirst (.redLED(RedPixels[1][12]), .l(RedPixels[1][13]), .a(RedPixels[0][12]), .r(RedPixels[1][11]), .b(RedPixels[2][12]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .startGameSwitch, .clk, .reset);
	selectingLightConfirmedFSM rowOneColTwelveSecond (.selectingLightConfirmed(rowOneColTwelveConfirmed), .l(RedPixels[1][13]), .a(RedPixels[0][12]), .r(RedPixels[1][11]), .b(RedPixels[2][12]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .confirmSeedSwitch(confirmSeedSwitchSignal), .startGameSwitch, .clk, .reset);
	greenSeedLightFSM rowOneColTwelveThird (.greenLED(GrnPixels[1][12]), .gl(GrnPixels[1][13]), .gla(GrnPixels[0][13]), .ga(GrnPixels[0][12]), .gra(GrnPixels[0][11]), .gr(GrnPixels[1][11]), .grb(GrnPixels[2][11]), .gb(GrnPixels[2][12]), .glb(GrnPixels[2][13]), .selectingLightConfirmed(rowOneColTwelveConfirmed), .startGameSwitch, .clk, .reset);
	
	
	logic rowOneColElevenConfirmed;
	redSelectingLightFSM rowOneColElevenFirst (.redLED(RedPixels[1][11]), .l(RedPixels[1][12]), .a(RedPixels[0][11]), .r(RedPixels[1][10]), .b(RedPixels[2][11]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .startGameSwitch, .clk, .reset);
	selectingLightConfirmedFSM rowOneColElevenSecond (.selectingLightConfirmed(rowOneColElevenConfirmed), .l(RedPixels[1][12]), .a(RedPixels[0][11]), .r(RedPixels[1][10]), .b(RedPixels[2][11]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .confirmSeedSwitch(confirmSeedSwitchSignal), .startGameSwitch, .clk, .reset);
	greenSeedLightFSM rowOneColElevenThird (.greenLED(GrnPixels[1][11]), .gl(GrnPixels[1][12]), .gla(GrnPixels[0][12]), .ga(GrnPixels[0][11]), .gra(GrnPixels[0][10]), .gr(GrnPixels[1][10]), .grb(GrnPixels[2][10]), .gb(GrnPixels[2][11]), .glb(GrnPixels[2][12]), .selectingLightConfirmed(rowOneColElevenConfirmed), .startGameSwitch, .clk, .reset);
	
	
	logic rowOneColTenConfirmed;
	redSelectingLightFSM rowOneColTenFirst (.redLED(RedPixels[1][10]), .l(RedPixels[1][11]), .a(RedPixels[0][10]), .r(RedPixels[1][9]), .b(RedPixels[2][10]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .startGameSwitch, .clk, .reset);
	selectingLightConfirmedFSM rowOneColTenSecond (.selectingLightConfirmed(rowOneColTenConfirmed), .l(RedPixels[1][11]), .a(RedPixels[0][10]), .r(RedPixels[1][9]), .b(RedPixels[2][10]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .confirmSeedSwitch(confirmSeedSwitchSignal), .startGameSwitch, .clk, .reset);
	greenSeedLightFSM rowOneColTenThird (.greenLED(GrnPixels[1][10]), .gl(GrnPixels[1][11]), .gla(GrnPixels[0][11]), .ga(GrnPixels[0][10]), .gra(GrnPixels[0][9]), .gr(GrnPixels[1][9]), .grb(GrnPixels[2][9]), .gb(GrnPixels[2][10]), .glb(GrnPixels[2][11]), .selectingLightConfirmed(rowOneColTenConfirmed), .startGameSwitch, .clk, .reset);
	
	
	logic rowOneColNineConfirmed;
	redSelectingLightFSM rowOneColNineFirst (.redLED(RedPixels[1][9]), .l(RedPixels[1][10]), .a(RedPixels[0][9]), .r(RedPixels[1][8]), .b(RedPixels[2][9]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .startGameSwitch, .clk, .reset);
	selectingLightConfirmedFSM rowOneColNineSecond (.selectingLightConfirmed(rowOneColNineConfirmed), .l(RedPixels[1][10]), .a(RedPixels[0][9]), .r(RedPixels[1][8]), .b(RedPixels[2][9]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .confirmSeedSwitch(confirmSeedSwitchSignal), .startGameSwitch, .clk, .reset);
	greenSeedLightFSM rowOneColNineThird (.greenLED(GrnPixels[1][9]), .gl(GrnPixels[1][10]), .gla(GrnPixels[0][10]), .ga(GrnPixels[0][9]), .gra(GrnPixels[0][8]), .gr(GrnPixels[1][8]), .grb(GrnPixels[2][8]), .gb(GrnPixels[2][9]), .glb(GrnPixels[2][10]), .selectingLightConfirmed(rowOneColNineConfirmed), .startGameSwitch, .clk, .reset);
	
	
	logic rowOneColEightConfirmed;
	redSelectingLightFSM rowOneColEightFirst (.redLED(RedPixels[1][8]), .l(RedPixels[1][9]), .a(RedPixels[0][8]), .r(RedPixels[1][15]), .b(RedPixels[2][8]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .startGameSwitch, .clk, .reset);
	selectingLightConfirmedFSM rowOneColEightSecond (.selectingLightConfirmed(rowOneColEightConfirmed), .l(RedPixels[1][9]), .a(RedPixels[0][8]), .r(RedPixels[1][15]), .b(RedPixels[2][8]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .confirmSeedSwitch(confirmSeedSwitchSignal), .startGameSwitch, .clk, .reset);
	greenSeedLightFSM rowOneColEightThird (.greenLED(GrnPixels[1][8]), .gl(GrnPixels[1][9]), .gla(GrnPixels[0][9]), .ga(GrnPixels[0][8]), .gra(GrnPixels[0][15]), .gr(GrnPixels[1][15]), .grb(GrnPixels[2][15]), .gb(GrnPixels[2][8]), .glb(GrnPixels[2][9]), .selectingLightConfirmed(rowOneColEightConfirmed), .startGameSwitch, .clk, .reset);
	
	
	/* GAP BETWEEN ROW ONE AND ROW TWO */
	
	
	logic rowTwoColFifteenConfirmed;
	redSelectingLightFSM rowTwoColFifteenFirst (.redLED(RedPixels[2][15]), .l(RedPixels[2][8]), .a(RedPixels[1][15]), .r(RedPixels[2][14]), .b(RedPixels[3][15]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .startGameSwitch, .clk, .reset);
	selectingLightConfirmedFSM rowTwoColFifteenSecond (.selectingLightConfirmed(rowTwoColFifteenConfirmed), .l(RedPixels[2][8]), .a(RedPixels[1][11]), .r(RedPixels[2][14]), .b(RedPixels[3][15]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .confirmSeedSwitch(confirmSeedSwitchSignal), .startGameSwitch, .clk, .reset);
	greenSeedLightFSM rowTwoColFifteenThird (.greenLED(GrnPixels[2][15]), .gl(GrnPixels[2][8]), .gla(GrnPixels[1][8]), .ga(GrnPixels[1][15]), .gra(GrnPixels[1][14]), .gr(GrnPixels[2][14]), .grb(GrnPixels[3][14]), .gb(GrnPixels[3][15]), .glb(GrnPixels[3][8]), .selectingLightConfirmed(rowTwoColFifteenConfirmed), .startGameSwitch, .clk, .reset);
	
	
	logic rowTwoColFourteenConfirmed;
	redSelectingLightFSM rowTwoColFourteenFirst (.redLED(RedPixels[2][14]), .l(RedPixels[2][15]), .a(RedPixels[1][14]), .r(RedPixels[2][13]), .b(RedPixels[3][14]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .startGameSwitch, .clk, .reset);
	selectingLightConfirmedFSM rowTwoColFourteenSecond (.selectingLightConfirmed(rowTwoColFourteenConfirmed), .l(RedPixels[2][15]), .a(RedPixels[1][14]), .r(RedPixels[2][13]), .b(RedPixels[3][14]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .confirmSeedSwitch(confirmSeedSwitchSignal), .startGameSwitch, .clk, .reset);
	greenSeedLightFSM rowTwoColFourteenThird (.greenLED(GrnPixels[2][14]), .gl(GrnPixels[2][15]), .gla(GrnPixels[1][15]), .ga(GrnPixels[1][14]), .gra(GrnPixels[1][13]), .gr(GrnPixels[2][13]), .grb(GrnPixels[3][13]), .gb(GrnPixels[3][14]), .glb(GrnPixels[3][15]), .selectingLightConfirmed(rowTwoColFourteenConfirmed), .startGameSwitch, .clk, .reset);
	
	
	logic rowTwoColThirteenConfirmed;
	redSelectingLightFSM rowTwoColThirteenFirst (.redLED(RedPixels[2][13]), .l(RedPixels[2][14]), .a(RedPixels[1][13]), .r(RedPixels[2][12]), .b(RedPixels[3][13]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .startGameSwitch, .clk, .reset);
	selectingLightConfirmedFSM rowTwoColThirteenSecond (.selectingLightConfirmed(rowTwoColThirteenConfirmed), .l(RedPixels[2][14]), .a(RedPixels[1][13]), .r(RedPixels[2][12]), .b(RedPixels[3][13]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .confirmSeedSwitch(confirmSeedSwitchSignal), .startGameSwitch, .clk, .reset);
	greenSeedLightFSM rowTwoColThirteenThird (.greenLED(GrnPixels[2][13]), .gl(GrnPixels[2][14]), .gla(GrnPixels[1][14]), .ga(GrnPixels[1][13]), .gra(GrnPixels[1][12]), .gr(GrnPixels[2][12]), .grb(GrnPixels[3][12]), .gb(GrnPixels[3][13]), .glb(GrnPixels[3][14]), .selectingLightConfirmed(rowTwoColThirteenConfirmed), .startGameSwitch, .clk, .reset);
	
	
	logic rowTwoColTwelveConfirmed;
	redSelectingLightFSM rowTwoColTwelveFirst (.redLED(RedPixels[2][12]), .l(RedPixels[2][13]), .a(RedPixels[1][12]), .r(RedPixels[2][11]), .b(RedPixels[3][12]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .startGameSwitch, .clk, .reset);
	selectingLightConfirmedFSM rowTwoColTwelveSecond (.selectingLightConfirmed(rowTwoColTwelveConfirmed), .l(RedPixels[2][13]), .a(RedPixels[1][12]), .r(RedPixels[2][11]), .b(RedPixels[3][12]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .confirmSeedSwitch(confirmSeedSwitchSignal), .startGameSwitch, .clk, .reset);
	greenSeedLightFSM rowTwoColTwelveThird (.greenLED(GrnPixels[2][12]), .gl(GrnPixels[2][13]), .gla(GrnPixels[1][13]), .ga(GrnPixels[1][12]), .gra(GrnPixels[1][11]), .gr(GrnPixels[2][11]), .grb(GrnPixels[3][11]), .gb(GrnPixels[3][12]), .glb(GrnPixels[3][13]), .selectingLightConfirmed(rowTwoColTwelveConfirmed), .startGameSwitch, .clk, .reset);
	
	
	logic rowTwoColElevenConfirmed;
	redSelectingLightFSM rowTwoColElevenFirst (.redLED(RedPixels[2][11]), .l(RedPixels[2][12]), .a(RedPixels[1][11]), .r(RedPixels[2][10]), .b(RedPixels[3][11]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .startGameSwitch, .clk, .reset);
	selectingLightConfirmedFSM rowTwoColElevenSecond (.selectingLightConfirmed(rowTwoColElevenConfirmed), .l(RedPixels[2][12]), .a(RedPixels[1][11]), .r(RedPixels[2][10]), .b(RedPixels[3][11]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .confirmSeedSwitch(confirmSeedSwitchSignal), .startGameSwitch, .clk, .reset);
	greenSeedLightFSM rowTwoColElevenThird (.greenLED(GrnPixels[2][11]), .gl(GrnPixels[2][12]), .gla(GrnPixels[1][12]), .ga(GrnPixels[1][11]), .gra(GrnPixels[1][10]), .gr(GrnPixels[2][10]), .grb(GrnPixels[3][10]), .gb(GrnPixels[3][11]), .glb(GrnPixels[3][12]), .selectingLightConfirmed(rowTwoColElevenConfirmed), .startGameSwitch, .clk, .reset);
	
	
	logic rowTwoColTenConfirmed;
	redSelectingLightFSM rowTwoColTenFirst (.redLED(RedPixels[2][10]), .l(RedPixels[2][11]), .a(RedPixels[1][10]), .r(RedPixels[2][9]), .b(RedPixels[3][10]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .startGameSwitch, .clk, .reset);
	selectingLightConfirmedFSM rowTwoColTenSecond (.selectingLightConfirmed(rowTwoColTenConfirmed), .l(RedPixels[2][11]), .a(RedPixels[1][10]), .r(RedPixels[2][9]), .b(RedPixels[3][10]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .confirmSeedSwitch(confirmSeedSwitchSignal), .startGameSwitch, .clk, .reset);
	greenSeedLightFSM rowTwoColTenThird (.greenLED(GrnPixels[2][10]), .gl(GrnPixels[2][11]), .gla(GrnPixels[1][11]), .ga(GrnPixels[1][10]), .gra(GrnPixels[1][9]), .gr(GrnPixels[2][9]), .grb(GrnPixels[3][9]), .gb(GrnPixels[3][10]), .glb(GrnPixels[3][11]), .selectingLightConfirmed(rowTwoColTenConfirmed), .startGameSwitch, .clk, .reset);
	
	
	logic rowTwoColNineConfirmed;
	redSelectingLightFSM rowTwoColNineFirst (.redLED(RedPixels[2][9]), .l(RedPixels[2][10]), .a(RedPixels[1][9]), .r(RedPixels[2][8]), .b(RedPixels[3][9]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .startGameSwitch, .clk, .reset);
	selectingLightConfirmedFSM rowTwoColNineSecond (.selectingLightConfirmed(rowTwoColNineConfirmed), .l(RedPixels[2][10]), .a(RedPixels[1][9]), .r(RedPixels[2][8]), .b(RedPixels[3][9]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .confirmSeedSwitch(confirmSeedSwitchSignal), .startGameSwitch, .clk, .reset);
	greenSeedLightFSM rowTwoColNineThird (.greenLED(GrnPixels[2][9]), .gl(GrnPixels[2][10]), .gla(GrnPixels[1][10]), .ga(GrnPixels[1][9]), .gra(GrnPixels[1][8]), .gr(GrnPixels[2][8]), .grb(GrnPixels[3][8]), .gb(GrnPixels[3][9]), .glb(GrnPixels[3][10]), .selectingLightConfirmed(rowTwoColNineConfirmed), .startGameSwitch, .clk, .reset);
	
	
	logic rowTwoColEightConfirmed;
	redSelectingLightFSM rowTwoColEightFirst (.redLED(RedPixels[2][8]), .l(RedPixels[2][9]), .a(RedPixels[1][8]), .r(RedPixels[2][15]), .b(RedPixels[3][8]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .startGameSwitch, .clk, .reset);
	selectingLightConfirmedFSM rowTwoColEightSecond (.selectingLightConfirmed(rowTwoColEightConfirmed), .l(RedPixels[2][9]), .a(RedPixels[1][8]), .r(RedPixels[2][15]), .b(RedPixels[3][8]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .confirmSeedSwitch(confirmSeedSwitchSignal), .startGameSwitch, .clk, .reset);
	greenSeedLightFSM rowTwoColEightThird (.greenLED(GrnPixels[2][8]), .gl(GrnPixels[2][9]), .gla(GrnPixels[1][9]), .ga(GrnPixels[1][8]), .gra(GrnPixels[1][15]), .gr(GrnPixels[2][15]), .grb(GrnPixels[3][15]), .gb(GrnPixels[3][8]), .glb(GrnPixels[3][9]), .selectingLightConfirmed(rowTwoColEightConfirmed), .startGameSwitch, .clk, .reset);
	
	
	/* GAP BETWEEN ROW TWO AND ROW THREE */
	
	
	logic rowThreeColFifteenConfirmed;
	redSelectingLightFSM rowThreeColFifteenFirst (.redLED(RedPixels[3][15]), .l(RedPixels[3][8]), .a(RedPixels[2][15]), .r(RedPixels[3][14]), .b(RedPixels[4][15]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .startGameSwitch, .clk, .reset);
	selectingLightConfirmedFSM rowThreeColFifteenSecond (.selectingLightConfirmed(rowThreeColFifteenConfirmed), .l(RedPixels[3][8]), .a(RedPixels[2][15]), .r(RedPixels[3][14]), .b(RedPixels[4][15]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .confirmSeedSwitch(confirmSeedSwitchSignal), .startGameSwitch, .clk, .reset);
	greenSeedLightFSM rowThreeColFifteenThird (.greenLED(GrnPixels[3][15]), .gl(GrnPixels[3][8]), .gla(GrnPixels[2][8]), .ga(GrnPixels[2][15]), .gra(GrnPixels[2][14]), .gr(GrnPixels[3][14]), .grb(GrnPixels[4][14]), .gb(GrnPixels[4][15]), .glb(GrnPixels[4][8]), .selectingLightConfirmed(rowThreeColFifteenConfirmed), .startGameSwitch, .clk, .reset);
	
	
	logic rowThreeColFourteenConfirmed;
	redSelectingLightFSM rowThreeColFourteenFirst (.redLED(RedPixels[3][14]), .l(RedPixels[3][15]), .a(RedPixels[2][14]), .r(RedPixels[3][13]), .b(RedPixels[4][14]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .startGameSwitch, .clk, .reset);
	selectingLightConfirmedFSM rowThreeColFourteenSecond (.selectingLightConfirmed(rowThreeColFourteenConfirmed), .l(RedPixels[3][15]), .a(RedPixels[2][14]), .r(RedPixels[3][13]), .b(RedPixels[4][14]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .confirmSeedSwitch(confirmSeedSwitchSignal), .startGameSwitch, .clk, .reset);
	greenSeedLightFSM rowThreeColFourteenThird (.greenLED(GrnPixels[3][14]), .gl(GrnPixels[3][15]), .gla(GrnPixels[2][15]), .ga(GrnPixels[2][14]), .gra(GrnPixels[2][13]), .gr(GrnPixels[3][13]), .grb(GrnPixels[4][13]), .gb(GrnPixels[4][14]), .glb(GrnPixels[4][15]), .selectingLightConfirmed(rowThreeColFourteenConfirmed), .startGameSwitch, .clk, .reset);
	
	
	logic rowThreeColThirteenConfirmed;
	redSelectingLightFSM rowThreeColThirteenFirst (.redLED(RedPixels[3][13]), .l(RedPixels[3][14]), .a(RedPixels[2][13]), .r(RedPixels[3][12]), .b(RedPixels[4][13]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .startGameSwitch, .clk, .reset);
	selectingLightConfirmedFSM rowThreeColThirteenSecond (.selectingLightConfirmed(rowThreeColThirteenConfirmed), .l(RedPixels[3][14]), .a(RedPixels[2][13]), .r(RedPixels[3][12]), .b(RedPixels[4][13]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .confirmSeedSwitch(confirmSeedSwitchSignal), .startGameSwitch, .clk, .reset);
	greenSeedLightFSM rowThreeColThirteenThird (.greenLED(GrnPixels[3][13]), .gl(GrnPixels[3][14]), .gla(GrnPixels[2][14]), .ga(GrnPixels[2][13]), .gra(GrnPixels[2][12]), .gr(GrnPixels[3][12]), .grb(GrnPixels[4][12]), .gb(GrnPixels[4][13]), .glb(GrnPixels[4][14]), .selectingLightConfirmed(rowThreeColThirteenConfirmed), .startGameSwitch, .clk, .reset);
	
	
	logic rowThreeColTwelveConfirmed;
	redSelectingLightDefaultOnFSM rowThreeColTwelveFirst (.redLED(RedPixels[3][12]), .l(RedPixels[3][13]), .a(RedPixels[2][12]), .r(RedPixels[3][11]), .b(RedPixels[4][12]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .startGameSwitch, .clk, .reset);
	selectingLightConfirmedDefaultOnFSM rowThreeColTwelveSecond (.selectingLightConfirmed(rowThreeColTwelveConfirmed), .l(RedPixels[3][13]), .a(RedPixels[2][12]), .r(RedPixels[3][11]), .b(RedPixels[4][12]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .confirmSeedSwitch(confirmSeedSwitchSignal), .startGameSwitch, .clk, .reset);
	greenSeedLightFSM rowThreeColTwelveThird (.greenLED(GrnPixels[3][12]), .gl(GrnPixels[3][13]), .gla(GrnPixels[2][13]), .ga(GrnPixels[2][12]), .gra(GrnPixels[2][11]), .gr(GrnPixels[3][11]), .grb(GrnPixels[4][11]), .gb(GrnPixels[4][12]), .glb(GrnPixels[4][13]), .selectingLightConfirmed(rowThreeColTwelveConfirmed), .startGameSwitch, .clk, .reset);
	
	
	logic rowThreeColElevenConfirmed;
	redSelectingLightFSM rowThreeColElevenFirst (.redLED(RedPixels[3][11]), .l(RedPixels[3][12]), .a(RedPixels[2][11]), .r(RedPixels[3][10]), .b(RedPixels[4][11]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .startGameSwitch, .clk, .reset);
	selectingLightConfirmedFSM rowThreeColElevenSecond (.selectingLightConfirmed(rowThreeColElevenConfirmed), .l(RedPixels[3][12]), .a(RedPixels[2][11]), .r(RedPixels[3][10]), .b(RedPixels[4][11]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .confirmSeedSwitch(confirmSeedSwitchSignal), .startGameSwitch, .clk, .reset);
	greenSeedLightFSM rowThreeColElevenThird (.greenLED(GrnPixels[3][11]), .gl(GrnPixels[3][12]), .gla(GrnPixels[2][12]), .ga(GrnPixels[2][11]), .gra(GrnPixels[2][10]), .gr(GrnPixels[3][10]), .grb(GrnPixels[4][10]), .gb(GrnPixels[4][11]), .glb(GrnPixels[4][12]), .selectingLightConfirmed(rowThreeColElevenConfirmed), .startGameSwitch, .clk, .reset);
	

	logic rowThreeColTenConfirmed;
	redSelectingLightFSM rowThreeColTenFirst (.redLED(RedPixels[3][10]), .l(RedPixels[3][11]), .a(RedPixels[2][10]), .r(RedPixels[3][9]), .b(RedPixels[4][10]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .startGameSwitch, .clk, .reset);
	selectingLightConfirmedFSM rowThreeColTenSecond (.selectingLightConfirmed(rowThreeColTenConfirmed), .l(RedPixels[3][11]), .a(RedPixels[2][10]), .r(RedPixels[3][9]), .b(RedPixels[4][10]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .confirmSeedSwitch(confirmSeedSwitchSignal), .startGameSwitch, .clk, .reset);
	greenSeedLightFSM rowThreeColTenThird (.greenLED(GrnPixels[3][10]), .gl(GrnPixels[3][11]), .gla(GrnPixels[2][11]), .ga(GrnPixels[2][10]), .gra(GrnPixels[2][9]), .gr(GrnPixels[3][9]), .grb(GrnPixels[4][9]), .gb(GrnPixels[4][10]), .glb(GrnPixels[4][11]), .selectingLightConfirmed(rowThreeColTenConfirmed), .startGameSwitch, .clk, .reset);

	
	logic rowThreeColNineConfirmed;
	redSelectingLightFSM rowThreeColNineFirst (.redLED(RedPixels[3][9]), .l(RedPixels[3][10]), .a(RedPixels[2][9]), .r(RedPixels[3][8]), .b(RedPixels[4][9]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .startGameSwitch, .clk, .reset);
	selectingLightConfirmedFSM rowThreeColNineSecond (.selectingLightConfirmed(rowThreeColNineConfirmed), .l(RedPixels[3][10]), .a(RedPixels[2][9]), .r(RedPixels[3][8]), .b(RedPixels[4][9]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .confirmSeedSwitch(confirmSeedSwitchSignal), .startGameSwitch, .clk, .reset);
	greenSeedLightFSM rowThreeColNineThird (.greenLED(GrnPixels[3][9]), .gl(GrnPixels[3][10]), .gla(GrnPixels[2][10]), .ga(GrnPixels[2][9]), .gra(GrnPixels[2][8]), .gr(GrnPixels[3][8]), .grb(GrnPixels[4][8]), .gb(GrnPixels[4][9]), .glb(GrnPixels[4][10]), .selectingLightConfirmed(rowThreeColNineConfirmed), .startGameSwitch, .clk, .reset);
	
	
	logic rowThreeColEightConfirmed;
	redSelectingLightFSM rowThreeColEightFirst (.redLED(RedPixels[3][8]), .l(RedPixels[3][9]), .a(RedPixels[2][8]), .r(RedPixels[3][15]), .b(RedPixels[4][8]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .startGameSwitch, .clk, .reset);
	selectingLightConfirmedFSM rowThreeColEightSecond (.selectingLightConfirmed(rowThreeColEightConfirmed), .l(RedPixels[3][9]), .a(RedPixels[2][8]), .r(RedPixels[3][15]), .b(RedPixels[4][8]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .confirmSeedSwitch(confirmSeedSwitchSignal), .startGameSwitch, .clk, .reset);
	greenSeedLightFSM rowThreeColEightThird (.greenLED(GrnPixels[3][8]), .gl(GrnPixels[3][9]), .gla(GrnPixels[2][9]), .ga(GrnPixels[2][8]), .gra(GrnPixels[2][15]), .gr(GrnPixels[3][15]), .grb(GrnPixels[4][15]), .gb(GrnPixels[4][8]), .glb(GrnPixels[4][9]), .selectingLightConfirmed(rowThreeColEightConfirmed), .startGameSwitch, .clk, .reset);
	
	
	/* GAP BETWEEN ROW THREE AND ROW FOUR */
	
	
	logic rowFourColFifteenConfirmed;
	redSelectingLightFSM rowFourColFifteenFirst (.redLED(RedPixels[4][15]), .l(RedPixels[4][8]), .a(RedPixels[3][15]), .r(RedPixels[4][14]), .b(RedPixels[5][15]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .startGameSwitch, .clk, .reset);
	selectingLightConfirmedFSM rowFourColFifteenSecond (.selectingLightConfirmed(rowFourColFifteenConfirmed), .l(RedPixels[4][8]), .a(RedPixels[3][15]), .r(RedPixels[4][14]), .b(RedPixels[5][15]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .confirmSeedSwitch(confirmSeedSwitchSignal), .startGameSwitch, .clk, .reset);
	greenSeedLightFSM rowFourColFifteenThird (.greenLED(GrnPixels[4][15]), .gl(GrnPixels[4][8]), .gla(GrnPixels[3][8]), .ga(GrnPixels[3][15]), .gra(GrnPixels[3][14]), .gr(GrnPixels[4][14]), .grb(GrnPixels[5][14]), .gb(GrnPixels[5][15]), .glb(GrnPixels[5][8]), .selectingLightConfirmed(rowFourColFifteenConfirmed), .startGameSwitch, .clk, .reset);
	
	
	logic rowFourColFourteenConfirmed;
	redSelectingLightFSM rowFourColFourteenFirst (.redLED(RedPixels[4][14]), .l(RedPixels[4][15]), .a(RedPixels[3][14]), .r(RedPixels[4][13]), .b(RedPixels[5][14]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .startGameSwitch, .clk, .reset);
	selectingLightConfirmedFSM rowFourColFourteenSecond (.selectingLightConfirmed(rowFourColFourteenConfirmed), .l(RedPixels[4][15]), .a(RedPixels[3][14]), .r(RedPixels[4][13]), .b(RedPixels[5][14]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .confirmSeedSwitch(confirmSeedSwitchSignal), .startGameSwitch, .clk, .reset);
	greenSeedLightFSM rowFourColFourteenThird (.greenLED(GrnPixels[4][14]), .gl(GrnPixels[4][15]), .gla(GrnPixels[3][15]), .ga(GrnPixels[3][14]), .gra(GrnPixels[3][13]), .gr(GrnPixels[4][13]), .grb(GrnPixels[5][13]), .gb(GrnPixels[5][14]), .glb(GrnPixels[5][15]), .selectingLightConfirmed(rowFourColFourteenConfirmed), .startGameSwitch, .clk, .reset);
	
	
	logic rowFourColThirteenConfirmed;
	redSelectingLightFSM rowFourColThirteenFirst (.redLED(RedPixels[4][13]), .l(RedPixels[4][14]), .a(RedPixels[3][13]), .r(RedPixels[4][12]), .b(RedPixels[5][13]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .startGameSwitch, .clk, .reset);
	selectingLightConfirmedFSM rowFourColThirteenSecond (.selectingLightConfirmed(rowFourColThirteenConfirmed), .l(RedPixels[4][14]), .a(RedPixels[3][13]), .r(RedPixels[4][12]), .b(RedPixels[5][13]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .confirmSeedSwitch(confirmSeedSwitchSignal), .startGameSwitch, .clk, .reset);
	greenSeedLightFSM rowFourColThirteenThird (.greenLED(GrnPixels[4][13]), .gl(GrnPixels[4][14]), .gla(GrnPixels[3][14]), .ga(GrnPixels[3][13]), .gra(GrnPixels[3][12]), .gr(GrnPixels[4][12]), .grb(GrnPixels[5][12]), .gb(GrnPixels[5][13]), .glb(GrnPixels[5][14]), .selectingLightConfirmed(rowFourColThirteenConfirmed), .startGameSwitch, .clk, .reset);
	
	
	logic rowFourColTwelveConfirmed;
	redSelectingLightFSM rowFourColTwelveFirst (.redLED(RedPixels[4][12]), .l(RedPixels[4][13]), .a(RedPixels[3][12]), .r(RedPixels[4][11]), .b(RedPixels[5][12]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .startGameSwitch, .clk, .reset);
	selectingLightConfirmedFSM rowFourColTwelveSecond (.selectingLightConfirmed(rowFourColTwelveConfirmed), .l(RedPixels[4][13]), .a(RedPixels[3][12]), .r(RedPixels[4][11]), .b(RedPixels[5][12]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .confirmSeedSwitch(confirmSeedSwitchSignal), .startGameSwitch, .clk, .reset);
	greenSeedLightFSM rowFourColTwelveThird (.greenLED(GrnPixels[4][12]), .gl(GrnPixels[4][13]), .gla(GrnPixels[3][13]), .ga(GrnPixels[3][12]), .gra(GrnPixels[3][11]), .gr(GrnPixels[4][11]), .grb(GrnPixels[5][11]), .gb(GrnPixels[5][12]), .glb(GrnPixels[5][13]), .selectingLightConfirmed(rowFourColTwelveConfirmed), .startGameSwitch, .clk, .reset);
	
	
	logic rowFourColElevenConfirmed;
	redSelectingLightFSM rowFourColElevenFirst (.redLED(RedPixels[4][11]), .l(RedPixels[4][12]), .a(RedPixels[3][11]), .r(RedPixels[4][10]), .b(RedPixels[5][11]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .startGameSwitch, .clk, .reset);
	selectingLightConfirmedFSM rowFourColElevenSecond (.selectingLightConfirmed(rowFourColElevenConfirmed), .l(RedPixels[4][12]), .a(RedPixels[3][11]), .r(RedPixels[4][10]), .b(RedPixels[5][11]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .confirmSeedSwitch(confirmSeedSwitchSignal), .startGameSwitch, .clk, .reset);
	greenSeedLightFSM rowFourColElevenThird (.greenLED(GrnPixels[4][11]), .gl(GrnPixels[4][12]), .gla(GrnPixels[3][12]), .ga(GrnPixels[3][11]), .gra(GrnPixels[3][10]), .gr(GrnPixels[4][10]), .grb(GrnPixels[5][10]), .gb(GrnPixels[5][11]), .glb(GrnPixels[5][12]), .selectingLightConfirmed(rowFourColElevenConfirmed), .startGameSwitch, .clk, .reset);
	
	
	logic rowFourColTenConfirmed;
	redSelectingLightFSM rowFourColTenFirst (.redLED(RedPixels[4][10]), .l(RedPixels[4][11]), .a(RedPixels[3][10]), .r(RedPixels[4][9]), .b(RedPixels[5][10]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .startGameSwitch, .clk, .reset);
	selectingLightConfirmedFSM rowFourColTenSecond (.selectingLightConfirmed(rowFourColTenConfirmed), .l(RedPixels[4][11]), .a(RedPixels[3][10]), .r(RedPixels[4][9]), .b(RedPixels[5][10]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .confirmSeedSwitch(confirmSeedSwitchSignal), .startGameSwitch, .clk, .reset);
	greenSeedLightFSM rowFourColTenThird (.greenLED(GrnPixels[4][10]), .gl(GrnPixels[4][11]), .gla(GrnPixels[3][11]), .ga(GrnPixels[3][10]), .gra(GrnPixels[3][9]), .gr(GrnPixels[4][9]), .grb(GrnPixels[5][9]), .gb(GrnPixels[5][10]), .glb(GrnPixels[5][11]), .selectingLightConfirmed(rowFourColTenConfirmed), .startGameSwitch, .clk, .reset);
	
	
	logic rowFourColNineConfirmed;
	redSelectingLightFSM rowFourColNineFirst (.redLED(RedPixels[4][9]), .l(RedPixels[4][10]), .a(RedPixels[3][9]), .r(RedPixels[4][8]), .b(RedPixels[5][9]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .startGameSwitch, .clk, .reset);
	selectingLightConfirmedFSM rowFourColNineSecond (.selectingLightConfirmed(rowFourColNineConfirmed), .l(RedPixels[4][10]), .a(RedPixels[3][9]), .r(RedPixels[4][8]), .b(RedPixels[5][9]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .confirmSeedSwitch(confirmSeedSwitchSignal), .startGameSwitch, .clk, .reset);
	greenSeedLightFSM rowFourColNineThird (.greenLED(GrnPixels[4][9]), .gl(GrnPixels[4][10]), .gla(GrnPixels[3][10]), .ga(GrnPixels[3][9]), .gra(GrnPixels[3][8]), .gr(GrnPixels[4][8]), .grb(GrnPixels[5][8]), .gb(GrnPixels[5][9]), .glb(GrnPixels[5][10]), .selectingLightConfirmed(rowFourColNineConfirmed), .startGameSwitch, .clk, .reset);
	
	
	logic rowFourColEightConfirmed;
	redSelectingLightFSM rowFourColEightFirst (.redLED(RedPixels[4][8]), .l(RedPixels[4][9]), .a(RedPixels[3][8]), .r(RedPixels[4][15]), .b(RedPixels[5][8]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .startGameSwitch, .clk, .reset);
	selectingLightConfirmedFSM rowFourColEightSecond (.selectingLightConfirmed(rowFourColEightConfirmed), .l(RedPixels[4][9]), .a(RedPixels[3][8]), .r(RedPixels[4][15]), .b(RedPixels[5][8]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .confirmSeedSwitch(confirmSeedSwitchSignal), .startGameSwitch, .clk, .reset);
	greenSeedLightFSM rowFourColEightThird (.greenLED(GrnPixels[4][8]), .gl(GrnPixels[4][9]), .gla(GrnPixels[3][9]), .ga(GrnPixels[3][8]), .gra(GrnPixels[3][15]), .gr(GrnPixels[4][15]), .grb(GrnPixels[5][15]), .gb(GrnPixels[5][8]), .glb(GrnPixels[5][9]), .selectingLightConfirmed(rowFourColEightConfirmed), .startGameSwitch, .clk, .reset);
	
	
	/* GAP BETWEEN ROW FOUR AND ROW FIVE */
	
	
	logic rowFiveColFifteenConfirmed;
	redSelectingLightFSM rowFiveColFifteenFirst (.redLED(RedPixels[5][15]), .l(RedPixels[5][8]), .a(RedPixels[4][15]), .r(RedPixels[5][14]), .b(RedPixels[6][15]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .startGameSwitch, .clk, .reset);
	selectingLightConfirmedFSM rowFiveColFifteenSecond (.selectingLightConfirmed(rowFiveColFifteenConfirmed), .l(RedPixels[5][8]), .a(RedPixels[4][15]), .r(RedPixels[5][14]), .b(RedPixels[6][15]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .confirmSeedSwitch(confirmSeedSwitchSignal), .startGameSwitch, .clk, .reset);
	greenSeedLightFSM rowFiveColFifteenThird (.greenLED(GrnPixels[5][15]), .gl(GrnPixels[5][8]), .gla(GrnPixels[4][8]), .ga(GrnPixels[4][15]), .gra(GrnPixels[4][14]), .gr(GrnPixels[5][14]), .grb(GrnPixels[6][14]), .gb(GrnPixels[6][15]), .glb(GrnPixels[6][8]), .selectingLightConfirmed(rowFiveColFifteenConfirmed), .startGameSwitch, .clk, .reset);
	
	
	logic rowFiveColFourteenConfirmed;
	redSelectingLightFSM rowFiveColFourteenFirst (.redLED(RedPixels[5][14]), .l(RedPixels[5][15]), .a(RedPixels[4][14]), .r(RedPixels[5][13]), .b(RedPixels[6][14]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .startGameSwitch, .clk, .reset);
	selectingLightConfirmedFSM rowFiveColFourteenSecond (.selectingLightConfirmed(rowFiveColFourteenConfirmed), .l(RedPixels[5][15]), .a(RedPixels[4][14]), .r(RedPixels[5][13]), .b(RedPixels[6][14]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .confirmSeedSwitch(confirmSeedSwitchSignal), .startGameSwitch, .clk, .reset);
	greenSeedLightFSM rowFiveColFourteenThird (.greenLED(GrnPixels[5][14]), .gl(GrnPixels[5][15]), .gla(GrnPixels[4][15]), .ga(GrnPixels[4][14]), .gra(GrnPixels[4][13]), .gr(GrnPixels[5][13]), .grb(GrnPixels[6][13]), .gb(GrnPixels[6][14]), .glb(GrnPixels[6][15]), .selectingLightConfirmed(rowFiveColFourteenConfirmed), .startGameSwitch, .clk, .reset);
	
	
	logic rowFiveColThirteenConfirmed;
	redSelectingLightFSM rowFiveColThirteenFirst (.redLED(RedPixels[5][13]), .l(RedPixels[5][14]), .a(RedPixels[4][13]), .r(RedPixels[5][12]), .b(RedPixels[6][13]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .startGameSwitch, .clk, .reset);
	selectingLightConfirmedFSM rowFiveColThirteenSecond (.selectingLightConfirmed(rowFiveColThirteenConfirmed), .l(RedPixels[5][14]), .a(RedPixels[4][13]), .r(RedPixels[5][12]), .b(RedPixels[6][13]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .confirmSeedSwitch(confirmSeedSwitchSignal), .startGameSwitch, .clk, .reset);
	greenSeedLightFSM rowFiveColThirteenThird (.greenLED(GrnPixels[5][13]), .gl(GrnPixels[5][14]), .gla(GrnPixels[4][14]), .ga(GrnPixels[4][13]), .gra(GrnPixels[4][12]), .gr(GrnPixels[5][12]), .grb(GrnPixels[6][12]), .gb(GrnPixels[6][13]), .glb(GrnPixels[6][14]), .selectingLightConfirmed(rowFiveColThirteenConfirmed), .startGameSwitch, .clk, .reset);
	
	
	logic rowFiveColTwelveConfirmed;
	redSelectingLightFSM rowFiveColTwelveFirst (.redLED(RedPixels[5][12]), .l(RedPixels[5][13]), .a(RedPixels[4][12]), .r(RedPixels[5][11]), .b(RedPixels[6][12]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .startGameSwitch, .clk, .reset);
	selectingLightConfirmedFSM rowFiveColTwelveSecond (.selectingLightConfirmed(rowFiveColTwelveConfirmed), .l(RedPixels[5][13]), .a(RedPixels[4][12]), .r(RedPixels[5][11]), .b(RedPixels[6][12]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .confirmSeedSwitch(confirmSeedSwitchSignal), .startGameSwitch, .clk, .reset);
	greenSeedLightFSM rowFiveColTwelveThird (.greenLED(GrnPixels[5][12]), .gl(GrnPixels[5][13]), .gla(GrnPixels[4][13]), .ga(GrnPixels[4][12]), .gra(GrnPixels[4][11]), .gr(GrnPixels[5][11]), .grb(GrnPixels[6][11]), .gb(GrnPixels[6][12]), .glb(GrnPixels[6][13]), .selectingLightConfirmed(rowFiveColTwelveConfirmed), .startGameSwitch, .clk, .reset);
	
	
	logic rowFiveColElevenConfirmed;
	redSelectingLightFSM rowFiveColElevenFirst (.redLED(RedPixels[5][11]), .l(RedPixels[5][12]), .a(RedPixels[4][11]), .r(RedPixels[5][10]), .b(RedPixels[6][11]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .startGameSwitch, .clk, .reset);
	selectingLightConfirmedFSM rowFiveColElevenSecond (.selectingLightConfirmed(rowFiveColElevenConfirmed), .l(RedPixels[5][12]), .a(RedPixels[4][11]), .r(RedPixels[5][10]), .b(RedPixels[6][11]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .confirmSeedSwitch(confirmSeedSwitchSignal), .startGameSwitch, .clk, .reset);
	greenSeedLightFSM rowFiveColElevenThird (.greenLED(GrnPixels[5][11]), .gl(GrnPixels[5][12]), .gla(GrnPixels[4][12]), .ga(GrnPixels[4][11]), .gra(GrnPixels[4][10]), .gr(GrnPixels[5][10]), .grb(GrnPixels[6][10]), .gb(GrnPixels[6][11]), .glb(GrnPixels[6][12]), .selectingLightConfirmed(rowFiveColElevenConfirmed), .startGameSwitch, .clk, .reset);
	
	
	logic rowFiveColTenConfirmed;
	redSelectingLightFSM rowFiveColTenFirst (.redLED(RedPixels[5][10]), .l(RedPixels[5][11]), .a(RedPixels[4][10]), .r(RedPixels[5][9]), .b(RedPixels[6][10]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .startGameSwitch, .clk, .reset);
	selectingLightConfirmedFSM rowFiveColTenSecond (.selectingLightConfirmed(rowFiveColTenConfirmed), .l(RedPixels[5][11]), .a(RedPixels[4][10]), .r(RedPixels[5][9]), .b(RedPixels[6][10]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .confirmSeedSwitch(confirmSeedSwitchSignal), .startGameSwitch, .clk, .reset);
	greenSeedLightFSM rowFiveColTenThird (.greenLED(GrnPixels[5][10]), .gl(GrnPixels[5][11]), .gla(GrnPixels[4][11]), .ga(GrnPixels[4][10]), .gra(GrnPixels[4][9]), .gr(GrnPixels[5][9]), .grb(GrnPixels[6][9]), .gb(GrnPixels[6][10]), .glb(GrnPixels[6][11]), .selectingLightConfirmed(rowFiveColTenConfirmed), .startGameSwitch, .clk, .reset);
	
	
	logic rowFiveColNineConfirmed;
	redSelectingLightFSM rowFiveColNineFirst (.redLED(RedPixels[5][9]), .l(RedPixels[5][10]), .a(RedPixels[4][9]), .r(RedPixels[5][8]), .b(RedPixels[6][9]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .startGameSwitch, .clk, .reset);
	selectingLightConfirmedFSM rowFiveColNineSecond (.selectingLightConfirmed(rowFiveColNineConfirmed), .l(RedPixels[5][10]), .a(RedPixels[4][9]), .r(RedPixels[5][8]), .b(RedPixels[6][9]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .confirmSeedSwitch(confirmSeedSwitchSignal), .startGameSwitch, .clk, .reset);
	greenSeedLightFSM rowFiveColNineThird (.greenLED(GrnPixels[5][9]), .gl(GrnPixels[5][10]), .gla(GrnPixels[4][10]), .ga(GrnPixels[4][9]), .gra(GrnPixels[4][8]), .gr(GrnPixels[5][8]), .grb(GrnPixels[6][8]), .gb(GrnPixels[6][9]), .glb(GrnPixels[6][10]), .selectingLightConfirmed(rowFiveColNineConfirmed), .startGameSwitch, .clk, .reset);
	
	
	logic rowFiveColEightConfirmed;
	redSelectingLightFSM rowFiveColEightFirst (.redLED(RedPixels[5][8]), .l(RedPixels[5][9]), .a(RedPixels[4][8]), .r(RedPixels[5][15]), .b(RedPixels[6][8]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .startGameSwitch, .clk, .reset);
	selectingLightConfirmedFSM rowFiveColEightSecond (.selectingLightConfirmed(rowFiveColEightConfirmed), .l(RedPixels[5][9]), .a(RedPixels[4][8]), .r(RedPixels[5][15]), .b(RedPixels[6][8]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .confirmSeedSwitch(confirmSeedSwitchSignal), .startGameSwitch, .clk, .reset);
	greenSeedLightFSM rowFiveColEightThird (.greenLED(GrnPixels[5][8]), .gl(GrnPixels[5][9]), .gla(GrnPixels[4][9]), .ga(GrnPixels[4][8]), .gra(GrnPixels[4][15]), .gr(GrnPixels[5][15]), .grb(GrnPixels[6][15]), .gb(GrnPixels[6][8]), .glb(GrnPixels[6][9]), .selectingLightConfirmed(rowFiveColEightConfirmed), .startGameSwitch, .clk, .reset);
	
	
	/* GAP BETWEEN ROW FIVE AND ROW SIX */
	
	
	logic rowSixColFifteenConfirmed;
	redSelectingLightFSM rowSixColFifteenFirst (.redLED(RedPixels[6][15]), .l(RedPixels[6][8]), .a(RedPixels[5][15]), .r(RedPixels[6][14]), .b(RedPixels[7][15]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .startGameSwitch, .clk, .reset);
	selectingLightConfirmedFSM rowSixColFifteenSecond (.selectingLightConfirmed(rowSixColFifteenConfirmed), .l(RedPixels[6][8]), .a(RedPixels[5][15]), .r(RedPixels[6][14]), .b(RedPixels[7][15]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .confirmSeedSwitch(confirmSeedSwitchSignal), .startGameSwitch, .clk, .reset);
	greenSeedLightFSM rowSixColFifteenThird (.greenLED(GrnPixels[6][15]), .gl(GrnPixels[6][8]), .gla(GrnPixels[5][8]), .ga(GrnPixels[5][15]), .gra(GrnPixels[5][14]), .gr(GrnPixels[6][14]), .grb(GrnPixels[7][14]), .gb(GrnPixels[7][15]), .glb(GrnPixels[7][8]), .selectingLightConfirmed(rowSixColFifteenConfirmed), .startGameSwitch, .clk, .reset);
	
	
	logic rowSixColFourteenConfirmed;
	redSelectingLightFSM rowSixColFourteenFirst (.redLED(RedPixels[6][14]), .l(RedPixels[6][15]), .a(RedPixels[5][14]), .r(RedPixels[6][13]), .b(RedPixels[7][14]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .startGameSwitch, .clk, .reset);
	selectingLightConfirmedFSM rowSixColFourteenSecond (.selectingLightConfirmed(rowSixColFourteenConfirmed), .l(RedPixels[6][15]), .a(RedPixels[5][14]), .r(RedPixels[6][13]), .b(RedPixels[7][14]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .confirmSeedSwitch(confirmSeedSwitchSignal), .startGameSwitch, .clk, .reset);
	greenSeedLightFSM rowSixColFourteenThird (.greenLED(GrnPixels[6][14]), .gl(GrnPixels[6][15]), .gla(GrnPixels[5][15]), .ga(GrnPixels[5][14]), .gra(GrnPixels[5][13]), .gr(GrnPixels[6][13]), .grb(GrnPixels[7][13]), .gb(GrnPixels[7][14]), .glb(GrnPixels[7][15]), .selectingLightConfirmed(rowSixColFourteenConfirmed), .startGameSwitch, .clk, .reset);
	
	
	logic rowSixColThirteenConfirmed;
	redSelectingLightFSM rowSixColThirteenFirst (.redLED(RedPixels[6][13]), .l(RedPixels[6][14]), .a(RedPixels[5][13]), .r(RedPixels[6][12]), .b(RedPixels[7][13]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .startGameSwitch, .clk, .reset);
	selectingLightConfirmedFSM rowSixColThirteenSecond (.selectingLightConfirmed(rowSixColThirteenConfirmed), .l(RedPixels[6][14]), .a(RedPixels[5][13]), .r(RedPixels[6][12]), .b(RedPixels[7][13]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .confirmSeedSwitch(confirmSeedSwitchSignal), .startGameSwitch, .clk, .reset);
	greenSeedLightFSM rowSixColThirteenThird (.greenLED(GrnPixels[6][13]), .gl(GrnPixels[6][14]), .gla(GrnPixels[5][14]), .ga(GrnPixels[5][13]), .gra(GrnPixels[5][12]), .gr(GrnPixels[6][12]), .grb(GrnPixels[7][12]), .gb(GrnPixels[7][13]), .glb(GrnPixels[7][14]), .selectingLightConfirmed(rowSixColThirteenConfirmed), .startGameSwitch, .clk, .reset);
	
	
	logic rowSixColTwelveConfirmed;
	redSelectingLightFSM rowSixColTwelveFirst (.redLED(RedPixels[6][12]), .l(RedPixels[6][13]), .a(RedPixels[5][12]), .r(RedPixels[6][11]), .b(RedPixels[7][12]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .startGameSwitch, .clk, .reset);
	selectingLightConfirmedFSM rowSixColTwelveSecond (.selectingLightConfirmed(rowSixColTwelveConfirmed), .l(RedPixels[6][13]), .a(RedPixels[5][12]), .r(RedPixels[6][11]), .b(RedPixels[7][12]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .confirmSeedSwitch(confirmSeedSwitchSignal), .startGameSwitch, .clk, .reset);
	greenSeedLightFSM rowSixColTwelveThird (.greenLED(GrnPixels[6][12]), .gl(GrnPixels[6][13]), .gla(GrnPixels[5][13]), .ga(GrnPixels[5][12]), .gra(GrnPixels[5][11]), .gr(GrnPixels[6][11]), .grb(GrnPixels[7][11]), .gb(GrnPixels[7][12]), .glb(GrnPixels[7][13]), .selectingLightConfirmed(rowSixColTwelveConfirmed), .startGameSwitch, .clk, .reset);
	
	
	logic rowSixColElevenConfirmed;
	redSelectingLightFSM rowSixColElevenFirst (.redLED(RedPixels[6][11]), .l(RedPixels[6][12]), .a(RedPixels[5][11]), .r(RedPixels[6][10]), .b(RedPixels[7][11]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .startGameSwitch, .clk, .reset);
	selectingLightConfirmedFSM rowSixColElevenSecond (.selectingLightConfirmed(rowSixColElevenConfirmed), .l(RedPixels[6][12]), .a(RedPixels[5][11]), .r(RedPixels[6][10]), .b(RedPixels[7][11]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .confirmSeedSwitch(confirmSeedSwitchSignal), .startGameSwitch, .clk, .reset);
	greenSeedLightFSM rowSixColElevenThird (.greenLED(GrnPixels[6][11]), .gl(GrnPixels[6][12]), .gla(GrnPixels[5][12]), .ga(GrnPixels[5][11]), .gra(GrnPixels[5][10]), .gr(GrnPixels[6][10]), .grb(GrnPixels[7][10]), .gb(GrnPixels[7][11]), .glb(GrnPixels[7][12]), .selectingLightConfirmed(rowSixColElevenConfirmed), .startGameSwitch, .clk, .reset);
	
	
	logic rowSixColTenConfirmed;
	redSelectingLightFSM rowSixColTenFirst (.redLED(RedPixels[6][10]), .l(RedPixels[6][11]), .a(RedPixels[5][10]), .r(RedPixels[6][9]), .b(RedPixels[7][10]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .startGameSwitch, .clk, .reset);
	selectingLightConfirmedFSM rowSixColTenSecond (.selectingLightConfirmed(rowSixColTenConfirmed), .l(RedPixels[6][11]), .a(RedPixels[5][10]), .r(RedPixels[6][9]), .b(RedPixels[7][10]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .confirmSeedSwitch(confirmSeedSwitchSignal), .startGameSwitch, .clk, .reset);
	greenSeedLightFSM rowSixColTenThird (.greenLED(GrnPixels[6][10]), .gl(GrnPixels[6][11]), .gla(GrnPixels[5][11]), .ga(GrnPixels[5][10]), .gra(GrnPixels[5][9]), .gr(GrnPixels[6][9]), .grb(GrnPixels[7][9]), .gb(GrnPixels[7][10]), .glb(GrnPixels[7][11]), .selectingLightConfirmed(rowSixColTenConfirmed), .startGameSwitch, .clk, .reset);
	
	
	logic rowSixColNineConfirmed;
	redSelectingLightFSM rowSixColNineFirst (.redLED(RedPixels[6][9]), .l(RedPixels[6][10]), .a(RedPixels[5][9]), .r(RedPixels[6][8]), .b(RedPixels[7][9]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .startGameSwitch, .clk, .reset);
	selectingLightConfirmedFSM rowSixColNineSecond (.selectingLightConfirmed(rowSixColNineConfirmed), .l(RedPixels[6][10]), .a(RedPixels[5][9]), .r(RedPixels[6][8]), .b(RedPixels[7][9]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .confirmSeedSwitch(confirmSeedSwitchSignal), .startGameSwitch, .clk, .reset);
	greenSeedLightFSM rowSixColNineThird (.greenLED(GrnPixels[6][9]), .gl(GrnPixels[6][10]), .gla(GrnPixels[5][10]), .ga(GrnPixels[5][9]), .gra(GrnPixels[5][8]), .gr(GrnPixels[6][8]), .grb(GrnPixels[7][8]), .gb(GrnPixels[7][9]), .glb(GrnPixels[7][10]), .selectingLightConfirmed(rowSixColNineConfirmed), .startGameSwitch, .clk, .reset);
	
	
	logic rowSixColEightConfirmed;
	redSelectingLightFSM rowSixColEightFirst (.redLED(RedPixels[6][8]), .l(RedPixels[6][9]), .a(RedPixels[5][8]), .r(RedPixels[6][15]), .b(RedPixels[7][8]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .startGameSwitch, .clk, .reset);
	selectingLightConfirmedFSM rowSixColEightSecond (.selectingLightConfirmed(rowSixColEightConfirmed), .l(RedPixels[6][9]), .a(RedPixels[5][8]), .r(RedPixels[6][15]), .b(RedPixels[7][8]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .confirmSeedSwitch(confirmSeedSwitchSignal), .startGameSwitch, .clk, .reset);
	greenSeedLightFSM rowSixColEightThird (.greenLED(GrnPixels[6][8]), .gl(GrnPixels[6][9]), .gla(GrnPixels[5][9]), .ga(GrnPixels[5][8]), .gra(GrnPixels[5][15]), .gr(GrnPixels[6][15]), .grb(GrnPixels[7][15]), .gb(GrnPixels[7][8]), .glb(GrnPixels[7][9]), .selectingLightConfirmed(rowSixColEightConfirmed), .startGameSwitch, .clk, .reset);
	
	
	/* GAP BETWEEN ROW SIX AND ROW SEVEN */
	
	
	logic rowSevenColFifteenConfirmed;
	redSelectingLightFSM rowSevenColFifteenFirst (.redLED(RedPixels[7][15]), .l(RedPixels[7][8]), .a(RedPixels[6][15]), .r(RedPixels[7][14]), .b(RedPixels[0][15]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .startGameSwitch, .clk, .reset);
	selectingLightConfirmedFSM rowSevenColFifteenSecond (.selectingLightConfirmed(rowSevenColFifteenConfirmed), .l(RedPixels[7][8]), .a(RedPixels[6][15]), .r(RedPixels[7][14]), .b(RedPixels[0][15]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .confirmSeedSwitch(confirmSeedSwitchSignal), .startGameSwitch, .clk, .reset);
	greenSeedLightFSM rowSevenColFifteenThird (.greenLED(GrnPixels[7][15]), .gl(GrnPixels[7][8]), .gla(GrnPixels[6][8]), .ga(GrnPixels[6][15]), .gra(GrnPixels[6][14]), .gr(GrnPixels[7][14]), .grb(GrnPixels[0][14]), .gb(GrnPixels[0][15]), .glb(GrnPixels[0][8]), .selectingLightConfirmed(rowSevenColFifteenConfirmed), .startGameSwitch, .clk, .reset);
	
	
	logic rowSevenColFourteenConfirmed;
	redSelectingLightFSM rowSevenColFourteenFirst (.redLED(RedPixels[7][14]), .l(RedPixels[7][15]), .a(RedPixels[6][14]), .r(RedPixels[7][13]), .b(RedPixels[0][14]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .startGameSwitch, .clk, .reset);
	selectingLightConfirmedFSM rowSevenColFourteenSecond (.selectingLightConfirmed(rowSevenColFourteenConfirmed), .l(RedPixels[7][15]), .a(RedPixels[6][14]), .r(RedPixels[7][13]), .b(RedPixels[0][14]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .confirmSeedSwitch(confirmSeedSwitchSignal), .startGameSwitch, .clk, .reset);
	greenSeedLightFSM rowSevenColFourteenThird (.greenLED(GrnPixels[7][14]), .gl(GrnPixels[7][15]), .gla(GrnPixels[6][15]), .ga(GrnPixels[6][14]), .gra(GrnPixels[6][13]), .gr(GrnPixels[7][13]), .grb(GrnPixels[0][13]), .gb(GrnPixels[0][14]), .glb(GrnPixels[0][15]), .selectingLightConfirmed(rowSevenColFourteenConfirmed), .startGameSwitch, .clk, .reset);
	
	
	logic rowSevenColThirteenConfirmed;
	redSelectingLightFSM rowSevenColThirteenFirst (.redLED(RedPixels[7][13]), .l(RedPixels[7][14]), .a(RedPixels[6][13]), .r(RedPixels[7][12]), .b(RedPixels[0][13]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .startGameSwitch, .clk, .reset);
	selectingLightConfirmedFSM rowSevenColThirteenSecond (.selectingLightConfirmed(rowSevenColThirteenConfirmed), .l(RedPixels[7][14]), .a(RedPixels[6][13]), .r(RedPixels[7][12]), .b(RedPixels[0][13]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .confirmSeedSwitch(confirmSeedSwitchSignal), .startGameSwitch, .clk, .reset);
	greenSeedLightFSM rowSevenColThirteenThird (.greenLED(GrnPixels[7][13]), .gl(GrnPixels[7][14]), .gla(GrnPixels[6][14]), .ga(GrnPixels[6][13]), .gra(GrnPixels[6][12]), .gr(GrnPixels[7][12]), .grb(GrnPixels[0][12]), .gb(GrnPixels[0][13]), .glb(GrnPixels[0][14]), .selectingLightConfirmed(rowSevenColThirteenConfirmed), .startGameSwitch, .clk, .reset);
	
	
	logic rowSevenColTwelveConfirmed;
	redSelectingLightFSM rowSevenColTwelveFirst (.redLED(RedPixels[7][12]), .l(RedPixels[7][13]), .a(RedPixels[6][12]), .r(RedPixels[7][11]), .b(RedPixels[0][12]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .startGameSwitch, .clk, .reset);
	selectingLightConfirmedFSM rowSevenColTwelveSecond (.selectingLightConfirmed(rowSevenColTwelveConfirmed), .l(RedPixels[7][13]), .a(RedPixels[6][12]), .r(RedPixels[7][11]), .b(RedPixels[0][12]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .confirmSeedSwitch(confirmSeedSwitchSignal), .startGameSwitch, .clk, .reset);
	greenSeedLightFSM rowSevenColTwelveThird (.greenLED(GrnPixels[7][12]), .gl(GrnPixels[7][13]), .gla(GrnPixels[6][13]), .ga(GrnPixels[6][12]), .gra(GrnPixels[6][11]), .gr(GrnPixels[7][11]), .grb(GrnPixels[0][11]), .gb(GrnPixels[0][12]), .glb(GrnPixels[0][13]), .selectingLightConfirmed(rowSevenColTwelveConfirmed), .startGameSwitch, .clk, .reset);
	
	
	logic rowSevenColElevenConfirmed;
	redSelectingLightFSM rowSevenColElevenFirst (.redLED(RedPixels[7][11]), .l(RedPixels[7][12]), .a(RedPixels[6][11]), .r(RedPixels[7][10]), .b(RedPixels[0][11]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .startGameSwitch, .clk, .reset);
	selectingLightConfirmedFSM rowSevenColElevenSecond (.selectingLightConfirmed(rowSevenColElevenConfirmed), .l(RedPixels[7][12]), .a(RedPixels[6][11]), .r(RedPixels[7][10]), .b(RedPixels[0][11]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .confirmSeedSwitch(confirmSeedSwitchSignal), .startGameSwitch, .clk, .reset);
	greenSeedLightFSM rowSevenColElevenThird (.greenLED(GrnPixels[7][11]), .gl(GrnPixels[7][12]), .gla(GrnPixels[6][12]), .ga(GrnPixels[6][11]), .gra(GrnPixels[6][10]), .gr(GrnPixels[7][10]), .grb(GrnPixels[0][10]), .gb(GrnPixels[0][11]), .glb(GrnPixels[0][12]), .selectingLightConfirmed(rowSevenColElevenConfirmed), .startGameSwitch, .clk, .reset);
	
	
	logic rowSevenColTenConfirmed;
	redSelectingLightFSM rowSevenColTenFirst (.redLED(RedPixels[7][10]), .l(RedPixels[7][11]), .a(RedPixels[6][10]), .r(RedPixels[7][9]), .b(RedPixels[0][10]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .startGameSwitch, .clk, .reset);
	selectingLightConfirmedFSM rowSevenColTenSecond (.selectingLightConfirmed(rowSevenColTenConfirmed), .l(RedPixels[7][11]), .a(RedPixels[6][10]), .r(RedPixels[7][9]), .b(RedPixels[0][10]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .confirmSeedSwitch(confirmSeedSwitchSignal), .startGameSwitch, .clk, .reset);
	greenSeedLightFSM rowSevenColTenThird (.greenLED(GrnPixels[7][10]), .gl(GrnPixels[7][11]), .gla(GrnPixels[6][11]), .ga(GrnPixels[6][10]), .gra(GrnPixels[6][9]), .gr(GrnPixels[7][9]), .grb(GrnPixels[0][9]), .gb(GrnPixels[0][10]), .glb(GrnPixels[0][11]), .selectingLightConfirmed(rowSevenColTenConfirmed), .startGameSwitch, .clk, .reset);
	
	
	logic rowSevenColNineConfirmed;
	redSelectingLightFSM rowSevenColNineFirst (.redLED(RedPixels[7][9]), .l(RedPixels[7][10]), .a(RedPixels[6][9]), .r(RedPixels[7][8]), .b(RedPixels[0][9]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .startGameSwitch, .clk, .reset);
	selectingLightConfirmedFSM rowSevenColNineSecond (.selectingLightConfirmed(rowSevenColNineConfirmed), .l(RedPixels[7][10]), .a(RedPixels[6][9]), .r(RedPixels[7][8]), .b(RedPixels[0][9]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .confirmSeedSwitch(confirmSeedSwitchSignal), .startGameSwitch, .clk, .reset);
	greenSeedLightFSM rowSevenColNineThird (.greenLED(GrnPixels[7][9]), .gl(GrnPixels[7][10]), .gla(GrnPixels[6][10]), .ga(GrnPixels[6][9]), .gra(GrnPixels[6][8]), .gr(GrnPixels[7][8]), .grb(GrnPixels[0][8]), .gb(GrnPixels[0][9]), .glb(GrnPixels[0][10]), .selectingLightConfirmed(rowSevenColNineConfirmed), .startGameSwitch, .clk, .reset);
	
	
	logic rowSevenColEightConfirmed;
	redSelectingLightFSM rowSevenColEightFirst (.redLED(RedPixels[7][8]), .l(RedPixels[7][9]), .a(RedPixels[6][8]), .r(RedPixels[7][15]), .b(RedPixels[0][8]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .startGameSwitch, .clk, .reset);
	selectingLightConfirmedFSM rowSevenColEightSecond (.selectingLightConfirmed(rowSevenColEightConfirmed), .l(RedPixels[7][9]), .a(RedPixels[6][8]), .r(RedPixels[7][15]), .b(RedPixels[0][8]), .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .confirmSeedSwitch(confirmSeedSwitchSignal), .startGameSwitch, .clk, .reset);
	greenSeedLightFSM rowSevenColEightThird (.greenLED(GrnPixels[7][8]), .gl(GrnPixels[7][9]), .gla(GrnPixels[6][9]), .ga(GrnPixels[6][8]), .gra(GrnPixels[6][15]), .gr(GrnPixels[7][15]), .grb(GrnPixels[0][15]), .gb(GrnPixels[0][8]), .glb(GrnPixels[0][9]), .selectingLightConfirmed(rowSevenColEightConfirmed), .startGameSwitch, .clk, .reset);
	
	
	
	
	
	
	
	
	
	
	
	
	/* Assign the rest of the LED array signals to be zero */
	
	assign RedPixels[0][7:0] = 8'b00000000;
	assign RedPixels[1][7:0] = 8'b00000000;
	assign RedPixels[2][7:0] = 8'b00000000;
	assign RedPixels[3][7:0] = 8'b00000000;
	assign RedPixels[4][7:0] = 8'b00000000;
	assign RedPixels[5][7:0] = 8'b00000000;
	assign RedPixels[6][7:0] = 8'b00000000;
	assign RedPixels[7][7:0] = 8'b00000000;
	assign RedPixels[08] = 16'b0000000000000000;
	assign RedPixels[09] = 16'b0000000000000000;
	assign RedPixels[10] = 16'b0000000000000000;
	assign RedPixels[11] = 16'b0000000000000000;
	assign RedPixels[12] = 16'b0000000000000000;
	assign RedPixels[13] = 16'b0000000000000000;
	assign RedPixels[14] = 16'b0000000000000000;
	assign RedPixels[15] = 16'b0000000000000000;
	
	
	
	assign GrnPixels[0][7:0] = 8'b00000000;
	assign GrnPixels[1][7:0] = 8'b00000000;
	assign GrnPixels[2][7:0] = 8'b00000000;
	assign GrnPixels[3][7:0] = 8'b00000000;
	assign GrnPixels[4][7:0] = 8'b00000000;
	assign GrnPixels[5][7:0] = 8'b00000000;
	assign GrnPixels[6][7:0] = 8'b00000000;
	assign GrnPixels[7][7:0] = 8'b00000000;
	assign GrnPixels[08] = 16'b0000000000000000;
	assign GrnPixels[09] = 16'b0000000000000000;
	assign GrnPixels[10] = 16'b0000000000000000;
	assign GrnPixels[11] = 16'b0000000000000000;
	assign GrnPixels[12] = 16'b0000000000000000;
	assign GrnPixels[13] = 16'b0000000000000000;
	assign GrnPixels[14] = 16'b0000000000000000;
	assign GrnPixels[15] = 16'b0000000000000000;
	
	
	
endmodule


module gameOfLifeUpdated_testbench();
	logic leftButton, rightButton, downButton, upButton, confirmSeedSwitch, startGameSwitch, clk, reset;
	logic [15:0][15:0] RedPixels;
	logic [15:0][15:0] GrnPixels;
	
	gameOfLifeUpdated dut(.*);
	
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	initial begin
		/* First seed state and subsequent next states (after game is started), was used to trace every signal from each of the three FSMs for the selected seed LEDs */
		
		reset <= 1; @(posedge clk);
		reset <= 0; leftButton <= 0; rightButton <= 0; downButton <= 0; upButton <= 0; confirmSeedSwitch <= 0; startGameSwitch <= 0; @(posedge clk);
		confirmSeedSwitch <= 1; @(posedge clk);
		confirmSeedSwitch <= 0; repeat(3) @(posedge clk);
		rightButton <= 1; @(posedge clk);
		rightButton <= 0; repeat(4) @(posedge clk);
		confirmSeedSwitch <= 1; @(posedge clk);
		confirmSeedSwitch <= 0; repeat(3) @(posedge clk);
		rightButton <= 1; @(posedge clk);
		rightButton <= 0; repeat(4) @(posedge clk);
		confirmSeedSwitch <= 1; @(posedge clk);
		confirmSeedSwitch <= 0; repeat(3) @(posedge clk);
		downButton <= 1; @(posedge clk);
		downButton <= 0; repeat(4) @(posedge clk);
		confirmSeedSwitch <= 1; @(posedge clk);
		confirmSeedSwitch <= 0; repeat(3) @(posedge clk);
		leftButton <= 1; @(posedge clk);
		leftButton <= 0; repeat(4) @(posedge clk);
		confirmSeedSwitch <= 1; @(posedge clk);
		confirmSeedSwitch <= 0; repeat(3) @(posedge clk);
		upButton <= 1; @(posedge clk);
		upButton <= 0; repeat(4) @(posedge clk);
		upButton <= 1; @(posedge clk);
		upButton <= 0; repeat(4) @(posedge clk);
		confirmSeedSwitch <= 1; @(posedge clk);
		confirmSeedSwitch <= 0; repeat(3) @(posedge clk);
		startGameSwitch <= 1; repeat(10) @(posedge clk);
		reset <= 1; @(posedge clk);
		reset <= 0; leftButton <= 0; rightButton <= 0; downButton <= 0; upButton <= 0; confirmSeedSwitch <= 0; startGameSwitch <= 0; @(posedge clk);
		
		
		 /* Better testbench to show, green LEDs cycle through always changing and longer pattern */
	/*	reset <= 1; @(posedge clk);
		reset <= 0; leftButton <= 0; rightButton <= 0; downButton <= 0; upButton <= 0; confirmSeedSwitch <= 0; startGameSwitch <= 0; @(posedge clk);
		confirmSeedSwitch <= 1; @(posedge clk);
		confirmSeedSwitch <= 0; repeat(3) @(posedge clk);
		leftButton <= 1; @(posedge clk);
		leftButton <= 0; repeat(4) @(posedge clk);
		confirmSeedSwitch <= 1; @(posedge clk);
		confirmSeedSwitch <= 0; repeat(3) @(posedge clk);
		upButton <= 1; @(posedge clk);
		upButton <= 0; repeat(4) @(posedge clk);
		rightButton <= 1; @(posedge clk);
		rightButton <= 0; repeat(4) @(posedge clk);
		confirmSeedSwitch <= 1; @(posedge clk);
		confirmSeedSwitch <= 0; repeat(3) @(posedge clk);
		downButton <= 1; @(posedge clk);
		downButton <= 0; repeat(4) @(posedge clk);
		downButton <= 1; @(posedge clk);
		downButton <= 0; repeat(4) @(posedge clk);
		confirmSeedSwitch <= 1; @(posedge clk);
		confirmSeedSwitch <= 0; repeat(3) @(posedge clk);
		rightButton <= 1; @(posedge clk);
		rightButton <= 0; repeat(4) @(posedge clk);
		confirmSeedSwitch <= 1; @(posedge clk);
		confirmSeedSwitch <= 0; repeat(3) @(posedge clk);
		startGameSwitch <= 1; repeat(50) @(posedge clk);
		reset <= 1; @(posedge clk);
		reset <= 0; leftButton <= 0; rightButton <= 0; downButton <= 0; upButton <= 0; confirmSeedSwitch <= 0; startGameSwitch <= 0; @(posedge clk); */
	  $stop;
	end
endmodule
	   

	
	
	
