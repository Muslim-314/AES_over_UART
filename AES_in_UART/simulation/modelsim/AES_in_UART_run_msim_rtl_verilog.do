transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+/home/muslim/HDD/AES_over_UART/AES_in_UART {/home/muslim/HDD/AES_over_UART/AES_in_UART/sbox.v}
vlog -vlog01compat -work work +incdir+/home/muslim/HDD/AES_over_UART/AES_in_UART {/home/muslim/HDD/AES_over_UART/AES_in_UART/key_generator.v}
vlog -vlog01compat -work work +incdir+/home/muslim/HDD/AES_over_UART/AES_in_UART {/home/muslim/HDD/AES_over_UART/AES_in_UART/g_function.v}
vlog -vlog01compat -work work +incdir+/home/muslim/HDD/AES_over_UART/AES_in_UART {/home/muslim/HDD/AES_over_UART/AES_in_UART/add_round_key.v}
vlog -vlog01compat -work work +incdir+/home/muslim/HDD/AES_over_UART/AES_in_UART {/home/muslim/HDD/AES_over_UART/AES_in_UART/inv_sbox.v}
vlog -vlog01compat -work work +incdir+/home/muslim/HDD/AES_over_UART/AES_in_UART {/home/muslim/HDD/AES_over_UART/AES_in_UART/inv_shiftrows.v}
vlog -vlog01compat -work work +incdir+/home/muslim/HDD/AES_over_UART/AES_in_UART {/home/muslim/HDD/AES_over_UART/AES_in_UART/inv_sub_byte.v}
vlog -vlog01compat -work work +incdir+/home/muslim/HDD/AES_over_UART/AES_in_UART {/home/muslim/HDD/AES_over_UART/AES_in_UART/inv_mix_column.v}
vlog -vlog01compat -work work +incdir+/home/muslim/HDD/AES_over_UART/AES_in_UART {/home/muslim/HDD/AES_over_UART/AES_in_UART/inv_single_round.v}
vlog -vlog01compat -work work +incdir+/home/muslim/HDD/AES_over_UART/AES_in_UART {/home/muslim/HDD/AES_over_UART/AES_in_UART/decipher.v}
vlog -vlog01compat -work work +incdir+/home/muslim/HDD/AES_over_UART/AES_in_UART {/home/muslim/HDD/AES_over_UART/AES_in_UART/inv_last_round.v}

