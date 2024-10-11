# File saved with Nlview 7.0r6  2020-01-29 bk=1.5227 VDI=41 GEI=36 GUI=JA:10.0 non-TLS-threadsafe
# 
# non-default properties - (restore without -noprops)
property attrcolor #000000
property attrfontsize 8
property autobundle 1
property backgroundcolor #ffffff
property boxcolor0 #000000
property boxcolor1 #000000
property boxcolor2 #000000
property boxinstcolor #000000
property boxpincolor #000000
property buscolor #008000
property closeenough 5
property createnetattrdsp 2048
property decorate 1
property elidetext 40
property fillcolor1 #ffffcc
property fillcolor2 #dfebf8
property fillcolor3 #f0f0f0
property gatecellname 2
property instattrmax 30
property instdrag 15
property instorder 1
property marksize 12
property maxfontsize 12
property maxzoom 5
property netcolor #19b400
property objecthighlight0 #ff00ff
property objecthighlight1 #ffff00
property objecthighlight2 #00ff00
property objecthighlight3 #0095ff
property objecthighlight4 #8000ff
property objecthighlight5 #ffc800
property objecthighlight7 #00ffff
property objecthighlight8 #ff00ff
property objecthighlight9 #ccccff
property objecthighlight10 #0ead00
property objecthighlight11 #cefc00
property objecthighlight12 #9e2dbe
property objecthighlight13 #ba6a29
property objecthighlight14 #fc0188
property objecthighlight15 #02f990
property objecthighlight16 #f1b0fb
property objecthighlight17 #fec004
property objecthighlight18 #149bff
property objecthighlight19 #eb591b
property overlapcolor #19b400
property pbuscolor #000000
property pbusnamecolor #000000
property pinattrmax 20
property pinorder 2
property pinpermute 0
property portcolor #000000
property portnamecolor #000000
property ripindexfontsize 8
property rippercolor #000000
property rubberbandcolor #000000
property rubberbandfontsize 12
property selectattr 0
property selectionappearance 2
property selectioncolor #0000ff
property sheetheight 44
property sheetwidth 68
property showmarks 1
property shownetname 0
property showpagenumbers 1
property showripindex 4
property timelimit 1
#
module new cnn_block_tb work:cnn_block_tb:NOFILE -nosplit
load symbol RTL_INV5 work INV pin I0 input pin O output fillcolor 1
load symbol cnn_block work:cnn_block:NOFILE HIERBOX pin ce input.left pin clk input.left pin conv_end output.right pin conv_valid output.right pin end_op output.right pin global_rst input.left pin valid_op output.right pinBus activation input.left [15:0] pinBus conv_out output.right [15:0] pinBus data_out output.right [15:0] pinBus weight1 input.left [143:0] boxcolor 1 fillcolor 2 minwidth 13%
load inst RTL_INV RTL_INV5 work -attr @cell(#000000) RTL_INV -pinAttr I0 @attr {FO=534, SL=N/A} -pinAttr O @attr {FO=534, SL=N/A} -pg 1 -lvl 1 -x 230 -y 40
load inst uut cnn_block work:cnn_block:NOFILE -autohide -attr @cell(#000000) cnn_block -pinAttr ce @attr SL=N/A -pinAttr clk @attr SL=N/A -pinAttr conv_end @attr n/c -pinAttr conv_valid @attr n/c -pinAttr end_op @attr n/c -pinAttr global_rst @attr SL=N/A -pinAttr valid_op @attr n/c -pinBusAttr activation @name activation[15:0] -pinBusAttr activation @attr SL=N/A -pinBusAttr conv_out @name conv_out[15:0] -pinBusAttr conv_out @attr n/c -pinBusAttr data_out @name data_out[15:0] -pinBusAttr data_out @attr n/c -pinBusAttr weight1 @name weight1[143:0] -pinBusAttr weight1 @attr SL=N/A -pg 1 -lvl 1 -x 230 -y 150
load net <const0> -ground -pin uut global_rst -pin uut activation[15] -pin uut activation[14] -pin uut activation[13] -pin uut activation[12] -pin uut activation[11] -pin uut activation[10] -pin uut activation[9] -pin uut activation[8] -pin uut activation[7] -pin uut activation[6] -pin uut activation[5] -pin uut activation[4] -pin uut activation[3] -pin uut activation[2] -pin uut activation[1] -pin uut activation[0] -pin uut weight1[138] -pin uut weight1[137] -pin uut weight1[134] -pin uut weight1[133] -pin uut weight1[131] -pin uut weight1[127] -pin uut weight1[126] -pin uut weight1[125] -pin uut weight1[124] -pin uut weight1[123] -pin uut weight1[122] -pin uut weight1[117] -pin uut weight1[115] -pin uut weight1[114] -pin uut weight1[113] -pin uut weight1[107] -pin uut weight1[104] -pin uut weight1[102] -pin uut weight1[101] -pin uut weight1[100] -pin uut weight1[97] -pin uut weight1[90] -pin uut weight1[88] -pin uut weight1[86] -pin uut weight1[85] -pin uut weight1[83] -pin uut weight1[82] -pin uut weight1[73] -pin uut weight1[71] -pin uut weight1[67] -pin uut weight1[65] -pin uut weight1[64] -pin uut weight1[57] -pin uut weight1[52] -pin uut weight1[47] -pin uut weight1[46] -pin uut weight1[45] -pin uut weight1[44] -pin uut weight1[43] -pin uut weight1[42] -pin uut weight1[41] -pin uut weight1[38] -pin uut weight1[37] -pin uut weight1[35] -pin uut weight1[32] -pin uut weight1[27] -pin uut weight1[26] -pin uut weight1[25] -pin uut weight1[24] -pin uut weight1[21] -pin uut weight1[19] -pin uut weight1[17] -pin uut weight1[9] -pin uut weight1[3] -pin uut weight1[1] -pin uut weight1[0]
load net <const1> -power -pin uut ce -pin uut weight1[143] -pin uut weight1[142] -pin uut weight1[141] -pin uut weight1[140] -pin uut weight1[139] -pin uut weight1[136] -pin uut weight1[135] -pin uut weight1[132] -pin uut weight1[130] -pin uut weight1[129] -pin uut weight1[128] -pin uut weight1[121] -pin uut weight1[120] -pin uut weight1[119] -pin uut weight1[118] -pin uut weight1[116] -pin uut weight1[112] -pin uut weight1[111] -pin uut weight1[110] -pin uut weight1[109] -pin uut weight1[108] -pin uut weight1[106] -pin uut weight1[105] -pin uut weight1[103] -pin uut weight1[99] -pin uut weight1[98] -pin uut weight1[96] -pin uut weight1[95] -pin uut weight1[94] -pin uut weight1[93] -pin uut weight1[92] -pin uut weight1[91] -pin uut weight1[89] -pin uut weight1[87] -pin uut weight1[84] -pin uut weight1[81] -pin uut weight1[80] -pin uut weight1[79] -pin uut weight1[78] -pin uut weight1[77] -pin uut weight1[76] -pin uut weight1[75] -pin uut weight1[74] -pin uut weight1[72] -pin uut weight1[70] -pin uut weight1[69] -pin uut weight1[68] -pin uut weight1[66] -pin uut weight1[63] -pin uut weight1[62] -pin uut weight1[61] -pin uut weight1[60] -pin uut weight1[59] -pin uut weight1[58] -pin uut weight1[56] -pin uut weight1[55] -pin uut weight1[54] -pin uut weight1[53] -pin uut weight1[51] -pin uut weight1[50] -pin uut weight1[49] -pin uut weight1[48] -pin uut weight1[40] -pin uut weight1[39] -pin uut weight1[36] -pin uut weight1[34] -pin uut weight1[33] -pin uut weight1[31] -pin uut weight1[30] -pin uut weight1[29] -pin uut weight1[28] -pin uut weight1[23] -pin uut weight1[22] -pin uut weight1[20] -pin uut weight1[18] -pin uut weight1[16] -pin uut weight1[15] -pin uut weight1[14] -pin uut weight1[13] -pin uut weight1[12] -pin uut weight1[11] -pin uut weight1[10] -pin uut weight1[8] -pin uut weight1[7] -pin uut weight1[6] -pin uut weight1[5] -pin uut weight1[4] -pin uut weight1[2]
load net clk_reg -pin RTL_INV I0 -pin RTL_INV O -pin uut clk
netloc clk_reg 1 0 2 20 80 400
levelinfo -pg 1 0 230 420
pagesize -pg 1 -db -bbox -sgen 0 0 420 300
show
fullfit
#
# initialize ictrl to current module cnn_block_tb work:cnn_block_tb:NOFILE
ictrl init topinfo |
