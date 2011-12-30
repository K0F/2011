// 
//  ttyplayer -  A player applet for `ttyrec' files
// 
//  Copyright (C) 2003  Hirotsugu Kakugawa. All rights reserved. 
//  See "COPYING" for distribution of this software. 
// 
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation; either version 2 of the License, or
//  (at your option) any later version.
// 
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program; if not, write to the Free Software
//  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
//

//
// Revision History
//   14 May  2003   First release.
//    3 June 2003   Fixed font & tty file directories
//


import java.io.*;
import java.applet.*;
import java.awt.*;
import java.awt.event.*;
import java.net.*;
import java.util.zip.*;


void setup(){
   size(320,240);
   textFont(loadFont("DejaVuSansMono-10.vlw")); 
  
  
  ttyplayer player = new ttyplayer();
  player.run();
  
}

void draw(){
  
  
}

