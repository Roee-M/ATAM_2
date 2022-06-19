gcc ./get_path.c ./test_read.c students_code.S -o main.out
if [ -f "main.out" ]; then
	timeout 20s ./main.out > out 2>/dev/null
	if [ $? -eq 0 ]; then
		diff out ./test1_res &>/dev/null
		if [ $? -eq 0 ]; then
			echo -e "\tBasic Read Test:\t\t\t\t\tPASS"
		else
			echo -e "\tBasic Read Test:\t\t\t\t\tFAIL - diff"
		fi
		else
			echo -e "\tBasic Read Test:\t\t\t\t\tFAIL - runtime error"
	fi
else
	echo -e "\tBasic Read Test:\t\t\t\t\tFAIL - compile with test error"
fi
gcc ./get_path_2.c ./test_read.c students_code.S -o main.out
if [ -f "main.out" ]; then
	timeout 20s ./main.out > out 2>/dev/null
	if [ $? -eq 0 ]; then
		diff out ./test2_res &>/dev/null
		if [ $? -eq 0 ]; then
			echo -e "\tAdvanced Read Test:\t\t\t\t\tPASS"
		else
			echo -e "\tAdvanced Read Test:\t\t\t\t\tFAIL - diff"
		fi
	else
		echo -e "\tAdvanced Read Test:\t\t\t\t\tFAIL - runtime error"
	fi
else
	echo -e "\tAdvanced Read Test:\t\t\t\t\tFAIL - compile with test error"
fi
gcc ./get_path.c ./test_hamm_weight.c students_code.S -o main.out
if [ -f "main.out" ]; then
	timeout 20s ./main.out > out 2>/dev/null
	if [ $? -eq 0 ]; then
		diff out ./test3_res &>/dev/null
		if [ $? -eq 0 ]; then
			echo -e "\tHamming Weight Test:\t\t\t\t\tPASS"
		else
			echo -e "\ttHamming Weight Test:\t\t\t\t\tFAIL - diff"
		fi
	else
		echo -e "\tHamming Weight Test:\t\t\t\t\tFAIL - runtime error"
	fi
else
	echo -e "\tHamming Weight Test:\t\t\t\t\tFAIL - compile with test error"
fi
gcc ./get_path.c ./test_hamm_weight_adv.c students_code.S -o main.out
if [ -f "main.out" ]; then
	timeout 20s ./main.out > out 2>/dev/null
	if [ $? -eq 0 ]; then
		diff out ./test4_res &>/dev/null
		if [ $? -eq 0 ]; then
			echo -e "\tAdvanced Hamming Weight Test:\t\t\t\tPASS"
		else
			echo -e "\tAdvanced tHamming Weight Test:\t\t\t\tFAIL - diff"
		fi
	else
		echo -e "\tAdvanced Hamming Weight Test:\t\t\t\tFAIL - runtime error"
	fi
else
	echo -e "\tAdvanced Hamming Weight Test:\t\t\tFAIL - compile with test error"
fi
gcc ./get_path.c ./test_negate_first_k.c students_code.S -o main.out
if [ -f "main.out" ]; then
	timeout 20s ./main.out > out 2>/dev/null
	if [ $? -eq 0 ]; then
		diff out ./test5_res &>/dev/null
		if [ $? -eq 0 ]; then
			echo -e "\tNegate First k Bits Test:\t\t\t\tPASS"
		else
			echo -e "\tNegate First k Bits Test:\t\t\t\tFAIL - diff"
		fi
	else
		echo -e "\tNegate First k Bits Test:\t\t\t\tFAIL - runtime error"
	fi
else
	echo -e "\tNegate First k Bits Test:\t\t\tFAIL - compile with test error"
fi
gcc ./get_path.c ./test_knuth_alg.c students_code.S -o main.out
if [ -f "main.out" ]; then
	timeout 20s ./main.out > out 2>/dev/null
	if [ $? -eq 0 ]; then
		diff out ./test6_res &>/dev/null
		if [ $? -eq 0 ]; then
			echo -e "\tKnuth Algorithm Test:\t\t\t\t\tPASS"
		else
			echo -e "\tKnuth Algorithm Test:\t\t\t\t\tFAIL - diff"
		fi
	else
		echo -e "\tKnuth Algorithm Test:\t\t\t\t\tFAIL - runtime error"
	fi
else
	echo -e "\tKnuth Algorithm Test:\t\t\t\t\tFAIL - compile with test error"
fi
gcc ./get_path.c ./test_knuth_alg_adv.c students_code.S -o main.out
if [ -f "main.out" ]; then
	timeout 60s ./main.out > out 2>/dev/null
	if [ $? -eq 0 ]; then
		diff out ./test7_res &>/dev/null
		if [ $? -eq 0 ]; then
			echo -e "\tAdvanced Knuth Algorithm Test (timeout 60s):\t\tPASS"
		else
			echo -e "\tAdvanced Knuth Algorithm Test (timeout 60s):\t\tFAIL - diff"
		fi
	else
		echo -e "\tAdvanced Knuth Algorithm Test (timeout 60s):\t\tFAIL - runtime / timeout error"
	fi
	timeout 30s ./main.out > out 2>/dev/null
	if [ $? -eq 0 ]; then
		diff out ./test7_res &>/dev/null
		if [ $? -eq 0 ]; then
			echo -e "\tAdvanced Knuth Algorithm Test (timeout 30s):\t\tPASS"
		else
			echo -e "\tAdvanced Knuth Algorithm Test (timeout 30s):\t\tFAIL - diff"
		fi
	else
		echo -e "\tAdvanced Knuth Algorithm Test (timeout 30s):\t\tFAIL - runtime / timeout error"
	fi
else
	echo -e "\tAdvanced Knuth Algorithm Test:\tFAIL - compile with test error"
fi
gcc ./get_path.c ./test_adv.c students_code.S -o main.out
if [ -f "main.out" ]; then
	timeout 60s ./main.out > out 2>/dev/null
	if [ $? -eq 0 ]; then
		diff out ./test8_res &>/dev/null
		if [ $? -eq 0 ]; then
			echo -e "\tAdvanced Test (timeout 60s):\t\t\t\tPASS"
		else
			echo -e "\tAdvanced Test (timeout 60s):\t\t\t\tFAIL - diff"
		fi
	else
		echo -e "\tAdvanced Test (timeout 60s):\t\t\t\tFAIL - runtime / timeout error"
	fi
	timeout 30s ./main.out > out 2>/dev/null
	if [ $? -eq 0 ]; then
		diff out ./test8_res &>/dev/null
		if [ $? -eq 0 ]; then
			echo -e "\tAdvanced Test (timeout 30s):\t\t\t\tPASS"
		else
			echo -e "\tAdvanced Test (timeout 30s):\t\t\t\tFAIL - diff"
		fi
	else
		echo -e "\tAdvanced Test (timeout 30s):\t\t\t\tFAIL - runtime / timeout error"
	fi
else
	echo -e "\tAdvanced Test:\t\t\t\tFAIL - compile with test error"
fi
gcc ./get_path.c ./test_all.c students_code.S -o main.out
if [ -f "main.out" ]; then
	timeout 60s ./main.out > out 2>/dev/null
	if [ $? -eq 0 ]; then
		diff out ./test9_res &>/dev/null
		if [ $? -eq 0 ]; then
			echo -e "\tFull Test (timeout 60s):\t\t\t\tPASS"
		else
			echo -e "\tFull Test (timeout 60s):\t\t\t\tFAIL - diff"
		fi
	else
		echo -e "\tFull Test (timeout 60s):\t\t\t\tFAIL - runtime / timeout error"
	fi
	timeout 30s ./main.out > out 2>/dev/null
	if [ $? -eq 0 ]; then
		diff out ./test9_res &>/dev/null
		if [ $? -eq 0 ]; then
			echo -e "\tFull Test (timeout 30s):\t\t\t\tPASS"
		else
			echo -e "\tFull Test (timeout 30s):\t\t\t\tFAIL - diff"
		fi
	else
		echo -e "\tFull Test (timeout 30s):\t\t\t\tFAIL - runtime / timeout error"
	fi
else
	echo -e "\tFull Test:\t\t\t\tFAIL - compile with test error"
fi
gcc ./get_path_2.c ./test_all.c students_code.S -o main.out
if [ -f "main.out" ]; then
	timeout 120s ./main.out > out 2>/dev/null
	if [ $? -eq 0 ]; then
		diff out ./test10_res &>/dev/null
		if [ $? -eq 0 ]; then
			echo -e "\tAdvanced Full Test (timeout 120s):\t\t\tPASS"
		else
			echo -e "\tAdvanced Full Test (timeout 120s):\t\t\tFAIL - diff"
		fi
	else
		echo -e "\tAdvanced Full Test (timeout 120s):\t\t\tFAIL - runtime / timeout error"
	fi
	timeout 60s ./main.out > out 2>/dev/null
	if [ $? -eq 0 ]; then
		diff out ./test10_res &>/dev/null
		if [ $? -eq 0 ]; then
			echo -e "\tAdvanced Full Test (timeout 60s):\t\t\tPASS"
		else
			echo -e "\tAdvanced Full Test (timeout 60s):\t\t\tFAIL - diff"
		fi
	else
		echo -e "\tAdvanced Full Test (timeout 60s):\t\t\tFAIL - runtime / timeout error"
	fi
	timeout 30s ./main.out > out 2>/dev/null
	if [ $? -eq 0 ]; then
		diff out ./test10_res &>/dev/null
		if [ $? -eq 0 ]; then
			echo -e "\tAdvanced Full Test (timeout 30s):\t\t\tPASS"
		else
			echo -e "\tAdvanced Full Test (timeout 30s):\t\t\tFAIL - diff"
		fi
	else
		echo -e "\tAdvanced Full Test (timeout 30s):\t\t\tFAIL - runtime / timeout error"
	fi
else
	echo -e "\tAdvanced Full Test:\t\t\tFAIL - compile with test error"
fi
gcc ./get_path_adv.S ./test_all.c students_code.S -o main.out
if [ -f "main.out" ]; then
	timeout 60s ./main.out > out 2>/dev/null
	if [ $? -eq 0 ]; then
		diff out ./test9_res &>/dev/null
		if [ $? -eq 0 ]; then
			echo -e "\tFull Test (Conventions Check):\t\t\t\tPASS"
		else
			echo -e "\tFull Test (Conventions Check):\t\t\t\tFAIL - diff"
		fi
	else
		echo -e "\tFull Test (Conventions Check):\t\t\t\tFAIL - runtime error"
	fi
else
	echo -e "\Full Test (Conventions Check):\t\t\tFAIL - compile with test error"
fi
sudo rm "main.out" "out" -rf
echo "END OF TEST"
