transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+/home/muslim/HDD/AES_over_UART/AES_in_UART {/home/muslim/HDD/AES_over_UART/AES_in_UART/sub_byte.v}
vlog -vlog01compat -work work +incdir+/home/muslim/HDD/AES_over_UART/AES_in_UART {/home/muslim/HDD/AES_over_UART/AES_in_UART/key_generator.v}
vlog -vlog01compat -work work +incdir+/home/muslim/HDD/AES_over_UART/AES_in_UART {/home/muslim/HDD/AES_over_UART/AES_in_UART/g_function.v}
vlog -vlog01compat -work work +incdir+/home/muslim/HDD/AES_over_UART/AES_in_UART {/home/muslim/HDD/AES_over_UART/AES_in_UART/shift_rows.v}
vlog -vlog01compat -work work +incdir+/home/muslim/HDD/AES_over_UART/AES_in_UART {/home/muslim/HDD/AES_over_UART/AES_in_UART/sbox.v}
vlog -vlog01compat -work work +incdir+/home/muslim/HDD/AES_over_UART/AES_in_UART {/home/muslim/HDD/AES_over_UART/AES_in_UART/Mix_column.v}
vlog -vlog01compat -work work +incdir+/home/muslim/HDD/AES_over_UART/AES_in_UART {/home/muslim/HDD/AES_over_UART/AES_in_UART/last_round.v}
vlog -vlog01compat -work work +incdir+/home/muslim/HDD/AES_over_UART/AES_in_UART {/home/muslim/HDD/AES_over_UART/AES_in_UART/encipher.v}
vlog -vlog01compat -work work +incdir+/home/muslim/HDD/AES_over_UART/AES_in_UART {/home/muslim/HDD/AES_over_UART/AES_in_UART/crc_padding.v}
vlog -vlog01compat -work work +incdir+/home/muslim/HDD/AES_over_UART/AES_in_UART {/home/muslim/HDD/AES_over_UART/AES_in_UART/CRC_MODULE.v}
vlog -vlog01compat -work work +incdir+/home/muslim/HDD/AES_over_UART/AES_in_UART {/home/muslim/HDD/AES_over_UART/AES_in_UART/add_round_key.v}
vlog -vlog01compat -work work +incdir+/home/muslim/HDD/AES_over_UART/AES_in_UART {/home/muslim/HDD/AES_over_UART/AES_in_UART/single_round.v}
vlog -vlog01compat -work work +incdir+/home/muslim/HDD/AES_over_UART/AES_in_UART {/home/muslim/HDD/AES_over_UART/AES_in_UART/PISO.v}
vlog -vlog01compat -work work +incdir+/home/muslim/HDD/AES_over_UART/AES_in_UART {/home/muslim/HDD/AES_over_UART/AES_in_UART/controller.v}
vlog -vlog01compat -work work +incdir+/home/muslim/HDD/AES_over_UART/AES_in_UART {/home/muslim/HDD/AES_over_UART/AES_in_UART/UDR.v}
vlog -vlog01compat -work work +incdir+/home/muslim/HDD/AES_over_UART/AES_in_UART {/home/muslim/HDD/AES_over_UART/AES_in_UART/BaudRateGenerator.v}
vlog -vlog01compat -work work +incdir+/home/muslim/HDD/AES_over_UART/AES_in_UART {/home/muslim/HDD/AES_over_UART/AES_in_UART/TOP_TX.v}
vlog -vlog01compat -work work +incdir+/home/muslim/HDD/AES_over_UART/AES_in_UART {/home/muslim/HDD/AES_over_UART/AES_in_UART/UART_Tx.v}

