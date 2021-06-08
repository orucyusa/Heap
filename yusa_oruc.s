; Heapsort
; Code Section
	AREA lab, CODE, READWRITE
	ENTRY
	LDR R0,=ARRAY
	LDR R1, [R0], #4
heapsort
    ; R0 = Array location
    ; R1 = Array length
    CMP     R1, #1              ; eger array'in size 0 veya 1 ise, döner.
    BLE     heapsort_done
    CMP     R1, #2              ; eger, arrayin size 2 ile karsilasitirir.
    BLE     heapsort_simple
    MOV     R11, #1             ; sabit degisken
    MOV     R12, #2             ; sabit degisken
    MOV     R10, #-1            ; gecici degisken 
    MOV     R10, R1, LSL #1     ; R10 = (len / 2) - 1
    SUB     R10, R10, #1
    SUB     R9, R1, #1          ; R9 = len - 1 
    MOV     R2, R10             ; R2 = baslangic indexi 
heapify
    ; R2 = Index
    MOV     R3, R2              ; R3 = en kucuk deger
	; R4 = Left index (2i+1)
	MUL 	R4, R2, R12
	ADD 	R4, R4, R11
	; R5 = Right index (2i+2)
	MUL 	R5, R2, R12
	ADD		R5, R5, R12
    LDR     R6, [R0, R2, LSL#2] ; R6 = indexte ki deger (R0 + (R2 * 4))
    MOV     R7, R6              ; R7 = suan ki en kucuk deger
heapify_left
    CMP     R4, R9              ; sol cocugu kontrol eder 
    BGT     heapify_right ; kontrolden sonra sag kontrole gecer
    LDR     R8, [R0, R4, LSL#2] ; R8 = sol deger (R0 + (R4 * 4)
    CMP     R8, R7              ; sol cocugun degeri ile en kucuk deger karsilasir
    BGT     heapify_right 		; eger sol cocuk en kucuk degerden buyukse saga kontrole geciyor
    MOV     R3, R4              ; eger sol cocuk en kucuk degerden kücükse en kucuk index degisir 
    MOV     R7, R8              ;  deger atanir.
heapify_right
    CMP     R5, R9              ; sag cocugu kontrol eder
    BGT     heapify_swap        ; degilse devam et 
    LDR     R8, [R0, R5, LSL#2] ; R8 = sag deger (R0 + (R5 * 4))
    CMP     R8, R7              ; sag cocugu degeri ile en kucuk deger karsilasir
    BGT     heapify_swap        ; eger sag cocuk en kucuk degerden buyukse swap islemine gecis yapar
    MOV     R3, R5              ; eger sag cocuk en kucuk degerden kücükse en kucuk index degisir.
    MOV     R7, R8              ;    deger atanir.
heapify_swap
    CMP     R2, R3              ; Baslangic degeri kontrol
    BEQ     heapify_next        ; eger öyleyse, donguden cikar.
    STR     R7, [R0, R2, LSL#2] ; degilse en buyuk ve ilk degerler degisir.
    STR     R6, [R0, R3, LSL#2]
    MOV     R2, R3              ;    indexteki en kucuk degerler degisir.
    B       heapify             ;    tekrar eder
heapify_next
    CMP     R10, #0             ; son index 0 ise heap bitmistir
    BEQ     heapify_pop
    SUB     R10, R10, #1        ; degilse, heap devam eder.
    MOV     R2, R10
    B       heapify
heapify_pop
    LDR     R3, [R0]            ; R3 = en buyuk deger 
    LDR     R4, [R0, R9, LSL#2] ; R4 = heap'in sonundan gelen deger	
    STR     R3, [R0, R9, LSL#2] ; heapin sonuna en kucuk degeri atar
    STR     R4, [R0]            ; heapin basina en buyuk degeri atar
    SUB     R9, #1              ; arrayin indexi kücülür 1 tane azaltir.
    CMP     R9, #1              ; eger sadece 2 tane item varsa karsilasitir.
    BEQ     heapsort_simple
    MOV     R2, #0              ; degilse heapify fonksiyonu calismaya devam eder.
    B       heapify
heapsort_simple
    
    LDR     R2, [R0]            ; ilk deger
    LDR     R3, [R0, #4]        ; ikinci deger
    CMP     R2, R3              ; deger karsilastir
	BGT		end_if		
    STR   R3, [R0]            ; degistir.
    STR   R2, [R0, #4]
end_if
heapsort_done

asd
	B asd
ARRAY
	DCD 5, 2, 7, 5, 3, 9
	
	END