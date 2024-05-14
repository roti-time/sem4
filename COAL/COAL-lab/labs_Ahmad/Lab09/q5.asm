.model small
.stack 100h
.286
.CODE
          ORG   100h
 Start:   
          mov   ax,13h
          int   10h
          push  0a000h
          pop   es
          mov   dx,160
          mov   di,100
          mov   al,0Fh
          mov   bx,20
          call  circle
          mov   ah,0
          int   16h
          mov   ax,3
          int   10h
          mov   ah,4ch
          int   21h

 circle:  
          mov   bp,0
          mov   si,bx
 c00:     
          call  _8pixels
          sub   bx,bp
          inc   bp
          sub   bx,bp
          jg    c01
          add   bx,si
          dec   si
          add   bx,si
 c01:     
          cmp   si,bp
          jae   c00
          ret
 _8pixels:
          call  _4pixels
 _4pixels:
          xchg  bp,si
          call  _2pixels
 _2pixels:
          neg   si
          push  di
          add   di,si
          imul  di,320
          add   di,dx
          mov   es:[di+bp],al
          sub   di,bp
          stosb
          pop   di
          ret
END Start