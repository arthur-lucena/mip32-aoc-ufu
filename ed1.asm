.data
str1:	.asciiz	"Digite um texto:\0"
str2:	.asciiz	"Digite outro texto:\0"
lstr1:	.space	10
lstr2:	.space	10
rstr:	.space 	20

.text

	la 		$a0, str1	# carregando endereço que será printrada
	addi 		$v0, $zero, 4	# informando ao syscall qye ele deve imprimir uma string
	syscall

	la 		$a0, lstr1	# carregando endereço onde a string vai ser armazenada
	addi 		$a1, $zero, 8	# informando tamanho máximo de caracteres
	addi 		$v0, $zero, 8	# informando ao syscall que ele deve ler uma string
	syscall

	la 		$a0, str2	# carregando endereço que será printrada
	addi 		$v0, $zero, 4	# informando ao syscall qye ele deve imprimir uma string
	syscall
	
	la 		$a0, lstr2	# carregando endereço onde a string vai ser armazenada
	addi 		$a1, $zero, 8	# informando tamanho máximo de caracteres
	addi 		$v0, $zero, 8	# informando ao syscall que ele deve ler uma string
	syscall
	
	la 		$a0, lstr1	# carregando endereço que será printrada
	la 		$a1, lstr2	# carregando endereço que será printrada

	jal		FUNC

	la 		$a0, rstr	# carregando endereço que será printrada
	addi 		$v0, $zero, 4	# informando ao syscall qye ele deve imprimir uma string
	syscall

	############ sai do programa ###############
	addi		$v0, $zero, 10 # informa ao syscall que ele deve finalizar o programa
	syscall
	
FUNC:	addi		$sp, $sp, -12
	sw		$ra, 12($sp)
	sw		$a0, 8($sp)
	sw		$a1, 4($sp)
	######### salvando argumentos e endereço de retorno ########
	
	lw		$t0, 8($sp)	# carregando primeira string
	lw		$t1, 4($sp)	# carregando segunda string	
	la 		$t2, rstr	# carregand endereço da string de retorno
	
FOR1:	
	lb		$t7, ($t0)	# carrega informação da string $t0 em $t7
        beq		$t7, 0x0000000a, SAIFOR1 	# verifica se essa informação é o \, do \0, se for sai do for
        sb		$t7, ($t2)	# salva informação carregada no $t7 em $t2
        addi		$t0, $t0, 1	# pula uma posição em $t0
        addi		$t2, $t2, 1	# pula uma posição em $t2

	j		FOR1
SAIFOR1:

FOR2:	
	lb		$t7, ($t1)	# carrega informação da string $t1 em $t7
        beqz		$t7, SAIFOR2 	# verifica se essa informação é o 0, que finaliza a string, se for sai do for
        sb		$t7, ($t2)	# salva informação carregada no $t7 em $t2
        addi		$t1, $t1, 1	# pula uma posição em $t1
        addi		$t2, $t2, 1	# pula uma posição em $t2

	j		FOR2
SAIFOR2:
	
	######### carregando o endereço de retorno e voltando a função ###########
	lw		$ra, 12($sp)
	jr		$ra
