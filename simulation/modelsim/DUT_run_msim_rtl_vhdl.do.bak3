transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {/home/winston/Documents/Acads/sem_2/EE309/iitb_risc/sign_extender_10.vhdl}
vcom -93 -work work {/home/winston/Documents/Acads/sem_2/EE309/iitb_risc/sign_extender_7.vhdl}
vcom -93 -work work {/home/winston/Documents/Acads/sem_2/EE309/iitb_risc/shifter_7.vhdl}
vcom -93 -work work {/home/winston/Documents/Acads/sem_2/EE309/iitb_risc/shifter_1.vhdl}
vcom -93 -work work {/home/winston/Documents/Acads/sem_2/EE309/iitb_risc/pc.vhdl}
vcom -93 -work work {/home/winston/Documents/Acads/sem_2/EE309/iitb_risc/ins_inter.vhd}
vcom -93 -work work {/home/winston/Documents/Acads/sem_2/EE309/iitb_risc/DUT.vhd}
vcom -93 -work work {/home/winston/Documents/Acads/sem_2/EE309/iitb_risc/mem.vhd}
vcom -93 -work work {/home/winston/Documents/Acads/sem_2/EE309/iitb_risc/regs.vhd}
vcom -93 -work work {/home/winston/Documents/Acads/sem_2/EE309/iitb_risc/alu.vhd}
vcom -93 -work work {/home/winston/Documents/Acads/sem_2/EE309/iitb_risc/temps.vhd}
vcom -93 -work work {/home/winston/Documents/Acads/sem_2/EE309/iitb_risc/ir.vhd}

vcom -93 -work work {/home/winston/Documents/Acads/sem_2/EE309/iitb_risc/Testbench.vhdl}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L maxv -L rtl_work -L work -voptargs="+acc"  Testbench

add wave *
view structure
view signals
run -all
