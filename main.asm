section .data
    szClassName db "DefaultClass", 0
    szWindowName db "Szam", 0
    string_reg_failed  db 'Failed to register main window', 0

    Instance dd 0
    mainWindow dd 0
    font dd 0

    lfFaceName db "MS Shell Dlg", 0

    buttonClass db "BUTTON", 0
    textBoxClass db "EDIT", 0

    ; groupBox
    groupBox dd 0
    szGroupBoxName db "Szam", 0

    inputBox dd 0
    
    ; BUTTONS
    buttonOsszeg dd 0
    szButtonOsszegName db "Osszeg", 0

    buttonSzama dd 0
    szButtonSzamaName db "Szama", 0

    buttonMax dd 0
    szButtonMaxName db "Maximum", 0

    buttonMin dd 0
    szButtonMinName db "Minumum", 0

    buttonTukor dd 0
    szButtonTukorName db "Tukor", 0

    buttonDuplazott dd 0
    szButtonDuplazottName db "Duplazott", 0

    buttonExit dd 0
    szButtonExitName db "Exit", 0

    listBox dd 0
    listBoxClass db "LISTBOX", 0


    szTextBuffer db 16 dup(0)
    szOutputBuffer db 16 dup(0)

    intValue dd 0

    intOsszeg dd 0
    intSzama dd 0
    intMinimum dd 0
    intMaximum dd 0
    intTukor dd 0
    intDuplazott dd 0

section .bss
    MessageBuffer resb 28
    c resb 48

section .text
    extern _RegisterClassExA@4
    extern _CreateWindowExA@48
    extern _DestroyWindow@4
    extern _MessageBoxA@16
    extern _GetModuleHandleA@4
    extern _PeekMessageA@20
    extern _TranslateMessage@4
    extern _DispatchMessageA@4
    extern _PostQuitMessage@4
    extern _DefWindowProcA@16
    extern _ShowWindow@8
    extern _UpdateWindow@4
    extern _ExitProcess@4
    extern _LoadCursorA@8
    extern _LoadIconA@8
    extern _SendMessageA@16
    extern _GetWindowTextA@12
    extern _CreateFontA@56
; custom functions
    extern _IsNumeric
    extern _StringToInt
    extern _IntToString
    extern _Osszeg
    extern _Szama
    extern _Minimum
    extern _Maximum
    extern _Tukor
    extern _Duplazott

    %define RegisterClassExA _RegisterClassExA@4
    %define CreateWindowExA _CreateWindowExA@48
    %define GetModuleHandleA _GetModuleHandleA@4
    %define ShowWindow _ShowWindow@8
    %define UpdateWindow _UpdateWindow@4
    %define GetMessageA _GetMessageA@16
    %define TranslateMessage _TranslateMessage@4
    %define DispatchMessageA _DispatchMessageA@4
    %define DestroyWindow _DestroyWindow@4
    %define PostQuitMessage _PostQuitMessage@4
    %define DefWindowProcA _DefWindowProcA@16
    %define MessageBoxA _MessageBoxA@16
    %define ExitProcess _ExitProcess@4
    %define PeekMessageA _PeekMessageA@20
    %define LoadCursorA _LoadCursorA@8
    %define LoadIconA _LoadIconA@8
    %define SendMessageA _SendMessageA@16
    %define GetWindowTextA _GetWindowTextA@12
    %define CreateFontA _CreateFontA@56
; custom functions
    %define IsNumeric _IsNumeric
    %define StringToInt _StringToInt
    %define IntToString _IntToString
    %define Osszeg _Osszeg
    %define Szama _Szama
    %define Minimum _Minimum
    %define Maximum _Maximum
    %define Tukor _Tukor
    %define Duplazott _Duplazott

    %define CW_USEDDEFAULT      0x80000000

    %define WS_OVERLAPPED       0x00000000
    %define WS_CHILD            0x40000000
    %define WS_MINIMIZE         0x20000000
    %define WS_VISIBLE          0x10000000
    %define WS_CAPTION          0x00C00000
    %define WS_BORDER           0x00800000
    %define WS_VSCROLL          0x00200000
    %define WS_HSCROLL          0x00100000
    %define WS_SYSMENU          0x00080000

    %define WS_MINIMIZEBOX      0x00020000
    %define WS_MAXIMIZEBOX      0x00010000

    %define BS_GROUPBOX         0x00000007
    %define ES_AUTOHSCROLL      0x0080

    %define LBS_NOTIFY          0x0001
    %define LBS_SORT            0x0002
    %define LBS_STANDARD        (LBS_NOTIFY | LBS_SORT | WS_VSCROLL | WS_BORDER)

    %define WM_SETTEXT          0x000C
    %define WM_SETFONT          0x0030
    %define LB_INSERTSTRING     0x0181
                             
    %define PM_REMOVE 1h

    %define WM_CREATE                       0x0001
    %define WM_DESTROY                      0x0002
    %define WM_COMMAND                      0x0111
    %define WM_QUIT                         0x0012
    %define WM_CLOSE                        0x0010

    %define CS_VREDRAW          0x0001
    %define CS_HREDRAW          0x0002
    %define CS_OWNDC            0x0020

    %define IDI_APPLICATION     32512

    %define BUTTON_EXIT 999
    %define BUTTON_OSSZEG 101
    %define BUTTON_SZAMA 102
    %define BUTTON_MINIMUM 103
    %define BUTTON_MAXIMUM 104
    %define BUTTON_TUKOR 105
    %define BUTTON_DUPLAZOTT 106

    global _start

_start:
        push lfFaceName
        push 0
        push 0
        push 0
        push 0
        push 0
        push 0
        push 0
        push 0
        push 400
        push 0
        push 0
        push 0
        push -11
        call CreateFontA

        mov dword[font], eax

	push 0
	call GetModuleHandleA
	mov dword [Instance], eax
    
	mov dword[c], 48 ; .cbSize
	mov dword[c+4], CS_OWNDC|CS_HREDRAW|CS_VREDRAW 
	mov dword[c+8], WindowProc	; lpfnWndProc
	mov dword[c+12], 0
	mov dword[c+16], 0
    
        mov eax, dword[Instance]
	mov dword[c+20], eax ; .hInstance
    
        push IDI_APPLICATION
        push 0
        call LoadIconA
	mov dword[c+24], eax ; .hIcon
    
        push IDI_APPLICATION
        push 0
        call LoadCursorA
        mov dword[c+28], eax ; .hCursor
    
        mov dword[c+32], 5 ; .hbrBackground
        mov dword[c+36], 0 ; .lpszMenuName
        mov dword[c+40], szClassName ; .lpszClassName
        mov dword[c+44], 0 ; .hIconSm
    
        lea eax, [c]
        push eax
        call RegisterClassExA
    
        cmp eax, 0
        jne .create
    
        push 0       
        push szWindowName    
        push string_reg_failed
        push 0         
        call MessageBoxA
    
        jmp exit

.create: ; CreateWindowExA
	push 0
        push dword[Instance]
        push 0
        push 0
	push 370	; h
        push 342	; w
        push CW_USEDDEFAULT	; y
        push CW_USEDDEFAULT	; x
	push WS_OVERLAPPED | WS_CAPTION | WS_SYSMENU | WS_MINIMIZEBOX
	push szWindowName
        push szClassName
        push 0
        call CreateWindowExA
    
        mov dword[mainWindow], eax

        push 1
        push dword[font]
        push WM_SETFONT
        push dword[mainWindow]
        call SendMessageA
    
    ; ShowWindow 
        push 1 					
        push dword[mainWindow]
	call ShowWindow
    
    ; UpdateWindow
        push dword[mainWindow]
	call UpdateWindow
    
message_loop:
	push PM_REMOVE
	push 0
	push 0
	push 0
	push MessageBuffer
	call PeekMessageA
    
        cmp eax, 0
        je nextloop
        
        cmp dword[MessageBuffer+4], WM_QUIT
        je exit
    
        push MessageBuffer
        call TranslateMessage
    
        push MessageBuffer
	call DispatchMessageA
    
nextloop:
        jmp near message_loop

exit:
        push dword 0
        call ExitProcess

	ret

;
; WindowProc
;
WindowProc:
	push ebp	; Saves the base pointer
	mov ebp, esp	; Saves the stack pointer

        cmp dword[ebp+12], WM_CREATE
        je .wm_create

        cmp dword[ebp+12], WM_COMMAND
        je .wm_command

        cmp dword[ebp+12], WM_CLOSE
        je .wm_close

        cmp dword[ebp+12], WM_DESTROY
        je .wm_destroy

        jmp .default

.wm_create:
    ; groupbox
        push 0
        push 0
        push 0
        push dword[ebp+8]
        push 50
        push 315
        push 10
        push 10
        push WS_VISIBLE | WS_CHILD | BS_GROUPBOX
        push szGroupBoxName
        push buttonClass
        push 0
        call CreateWindowExA

        mov dword[groupBox], eax

        push 1
        push dword[font]
        push WM_SETFONT
        push dword[groupBox]
        call SendMessageA

    ; textbox
        push 0
        push 0
        push 0
        push dword[groupBox]
        push 20
        push 295
        push 20
        push 10
        push WS_VISIBLE | WS_CHILD | WS_BORDER | ES_AUTOHSCROLL
        push 0
        push textBoxClass
        push 0
        call CreateWindowExA

        mov dword[inputBox], eax

        push 1
        push dword[font]
        push WM_SETFONT
        push dword[inputBox]
        call SendMessageA

    ; osszeg
        push 0
        push 0
        push BUTTON_OSSZEG
        push dword[ebp+8]
        push 25
        push 150
        push 65
        push 10
        push WS_VISIBLE | WS_CHILD
        push szButtonOsszegName
        push buttonClass
        push 0
        call CreateWindowExA

        mov dword[buttonOsszeg], eax

        push 1
        push dword[font]
        push WM_SETFONT
        push dword[buttonOsszeg]
        call SendMessageA

    ; szama
        push 0
        push 0
        push BUTTON_SZAMA
        push dword[ebp+8]
        push 25
        push 150
        push 65
        push 175
        push WS_VISIBLE | WS_CHILD
        push szButtonSzamaName
        push buttonClass
        push 0
        call CreateWindowExA

        mov dword[buttonSzama], eax

        push 1
        push dword[font]
        push WM_SETFONT
        push dword[buttonSzama]
        call SendMessageA

    ; minimum
        push 0
        push 0
        push BUTTON_MINIMUM
        push dword[ebp+8]
        push 25
        push 150
        push 95
        push 10
        push WS_VISIBLE | WS_CHILD
        push szButtonMinName
        push buttonClass
        push 0
        call CreateWindowExA

        mov dword[buttonMin], eax

        push 1
        push dword[font]
        push WM_SETFONT
        push dword[buttonMin]
        call SendMessageA

    ; maximum
        push 0
        push 0
        push BUTTON_MAXIMUM
        push dword[ebp+8]
        push 25
        push 150
        push 95
        push 175
        push WS_VISIBLE | WS_CHILD
        push szButtonMaxName
        push buttonClass
        push 0
        call CreateWindowExA

        mov dword[buttonMax], eax

        push 1
        push dword[font]
        push WM_SETFONT
        push dword[buttonMax]
        call SendMessageA

    ; tukor
        push 0
        push 0
        push BUTTON_TUKOR
        push dword[ebp+8]
        push 25
        push 150
        push 125
        push 10
        push WS_VISIBLE | WS_CHILD
        push szButtonTukorName
        push buttonClass
        push 0
        call CreateWindowExA

        mov dword[buttonTukor], eax

        push 1
        push dword[font]
        push WM_SETFONT
        push dword[buttonTukor]
        call SendMessageA

    ; duplazott
        push 0
        push 0
        push BUTTON_DUPLAZOTT
        push dword[ebp+8]
        push 25
        push 150
        push 125
        push 175
        push WS_VISIBLE | WS_CHILD
        push szButtonDuplazottName
        push buttonClass
        push 0
        call CreateWindowExA

        mov dword[buttonDuplazott], eax

        push 1
        push dword[font]
        push WM_SETFONT
        push dword[buttonDuplazott]
        call SendMessageA

    ; listbox
        push 0
        push 0
        push 69
        push dword[ebp+8]
        push 150
        push 315
        push 155
        push 10
        push WS_VISIBLE | WS_CHILD | LBS_STANDARD | LBS_NOTIFY | LBS_SORT
        push 0
        push listBoxClass
        push 0
        call CreateWindowExA

        mov dword[listBox], eax

        push 1
        push dword[font]
        push WM_SETFONT
        push dword[listBox]
        call SendMessageA

    ; button exit
        push 0
        push 0
        push BUTTON_EXIT
        push dword[ebp+8]
        push 25
        push 315
        push 305
        push 10
        push WS_VISIBLE | WS_CHILD
        push szButtonExitName
        push buttonClass
        push 0
        call CreateWindowExA

        mov dword[buttonExit], eax

        push 1
        push dword[font]
        push WM_SETFONT
        push dword[buttonExit]
        call SendMessageA

        jmp .end_case

.wm_command:   
        mov eax, dword[ebp+16]

        cmp eax, BUTTON_EXIT
        je .funcButtonExit

        cmp eax, BUTTON_OSSZEG
        je .funcButtonOsszeg

        cmp eax, BUTTON_SZAMA
        je .funcButtonSzama

        cmp eax, BUTTON_MINIMUM
        je .funcButtonMinimum

        cmp eax, BUTTON_MAXIMUM
        je .funcButtonMaximum

        cmp eax, BUTTON_TUKOR
        je .funcButtonTukor

        cmp eax, BUTTON_DUPLAZOTT
        je .funcButtonDuplazott

        jmp .default

.funcButtonExit:
        push 0
        call ExitProcess

        jmp .end_case

.funcButtonOsszeg:
        push 100
        push szTextBuffer
        push dword[inputBox]
        call GetWindowTextA

        push szTextBuffer
        call StringToInt

        mov dword[intValue], eax

        push dword[intValue]
        call Osszeg

        mov dword[intOsszeg], eax

        push szOutputBuffer
        push dword[intOsszeg]
        call IntToString

        push szOutputBuffer    ; lpString
        push -1                ; nIndex
        push LB_INSERTSTRING   ; wMsg
        push dword[listBox]    ; hWnd
        call SendMessageA

        jmp .end_funcButtonOsszeg

.end_funcButtonOsszeg:
        jmp .end_case

.funcButtonSzama:
        push 100
        push szTextBuffer
        push dword[inputBox]
        call GetWindowTextA

        push szTextBuffer
        call StringToInt

        mov dword[intValue], eax

        push dword[intValue]
        call Szama

        mov dword[intSzama], eax

        push szOutputBuffer
        push dword[intSzama]
        call IntToString

        push szOutputBuffer    
        push -1                
        push LB_INSERTSTRING   
        push dword[listBox]    
        call SendMessageA

        jmp .end_funcButtonSzama

.end_funcButtonSzama:
        jmp .end_case

.funcButtonMinimum:
        push 100
        push szTextBuffer
        push dword[inputBox]
        call GetWindowTextA

        push szTextBuffer
        call StringToInt

        mov dword[intValue], eax

        push dword[intValue]
        call Minimum

        mov dword[intMinimum], eax

        push szOutputBuffer
        push dword[intMinimum]
        call IntToString

        push szOutputBuffer    
        push -1                
        push LB_INSERTSTRING   
        push dword[listBox]    
        call SendMessageA

        jmp .end_funcButtonMinimum

.end_funcButtonMinimum:
        jmp .end_case

.funcButtonMaximum:
        push 100
        push szTextBuffer
        push dword[inputBox]
        call GetWindowTextA

        push szTextBuffer
        call StringToInt

        mov dword[intValue], eax

        push dword[intValue]
        call Maximum

        mov dword[intMaximum], eax

        push szOutputBuffer
        push dword[intMaximum]
        call IntToString

        push szOutputBuffer    
        push -1                
        push LB_INSERTSTRING   
        push dword[listBox]    
        call SendMessageA

        jmp .end_funcButtonMaximum

.end_funcButtonMaximum:
        jmp .end_case

.funcButtonTukor:
        push 100
        push szTextBuffer
        push dword[inputBox]
        call GetWindowTextA

        push szTextBuffer
        call StringToInt

        mov dword[intValue], eax

        push dword[intValue]
        call Tukor

        mov dword[intTukor], eax

        push szOutputBuffer
        push dword[intTukor]
        call IntToString

        push szOutputBuffer    
        push -1                
        push LB_INSERTSTRING   
        push dword[listBox]    
        call SendMessageA

        jmp .end_funcButtonTukor

.end_funcButtonTukor:
        jmp .end_case

.funcButtonDuplazott:
        push 100
        push szTextBuffer
        push dword[inputBox]
        call GetWindowTextA

        push szTextBuffer
        call StringToInt

        mov dword[intValue], eax

        push dword[intValue]
        call Duplazott

        mov dword[intDuplazott], eax

        push szOutputBuffer
        push dword[intDuplazott]
        call IntToString

        push szOutputBuffer    
        push -1                
        push LB_INSERTSTRING   
        push dword[listBox]    
        call SendMessageA

        jmp .end_funcButtonDuplazott

.end_funcButtonDuplazott:
        jmp .end_case


        jmp .end_case

.wm_destroy:
        push 0
        call PostQuitMessage

        jmp .end_case

.wm_close:
        push dword[ebp+8]
        call DestroyWindow

        jmp .end_case

.default:
	push dword[ebp+20]	; LPARAM
        push dword[ebp+16]	; WPARAM
        push dword[ebp+12]	; Msg
        push dword[ebp+8]	; hWnd
	    call DefWindowProcA
    
        mov esp, ebp
        pop ebp
	ret

.end_case: ; return 0
        mov esp, ebp
        pop ebp
        ret