.data
str1:	.asciiz	"Digite um texto:\0"
str2:	.asciiz	"Digite outro texto:\0"
lstr1:	.space	10
lstr2:	.space	10

.text

	la 		$a0, str1	# carregando endereço que será printrada
	addi 		$v0, $zero, 4	# informando ao syscall qye ele deve imprimir uma string
	syscall

	la 		$a0, lstr1	# carregando endereço onde a string vai ser armazenada
	addi 		$a1, $zero, 10	# informando tamanho máximo de caracteres
	addi 		$v0, $zero, 8	# informando ao syscall que ele deve ler uma string
	syscall

	la 		$a0, str2	# carregando endereço que será printrada
	addi 		$v0, $zero, 4	# informando ao syscall qye ele deve imprimir uma string
	syscall
	
	la 		$a0, lstr2	# carregando endereço onde a string vai ser armazenada
	addi 		$a1, $zero, 10	# informando tamanho máximo de caracteres
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
	
FUNC:
	addi		$sp, $sp, -12
	sw		$ra, 12($sp)
	sw		$a0, 8($sp)
	sw		$a1, 4($sp)
	######### salvando argumentos e endereço de retorno ########
	
	######### carregando o endereço de retorno e voltando a função ###########
	lw		$ra, 12($sp)
	jr		$ra
