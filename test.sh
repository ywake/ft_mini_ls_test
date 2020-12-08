test () {
	ls -1tr > $2/diffs/$1_ls
	$2/ft_mini_ls > $2/diffs/$1_ft
	diff $2/diffs/$1_ls $2/diffs/$1_ft
	if [ $? -eq 0 ]; then
		echo -e "OK"
	fi
}

echo "[test] command line arg"
./ft_mini_ls a b c d e
echo -e "----------------\n"

echo "[test] nm -u ft_mini_ls"
nm -u ft_mini_ls
echo -e "----------------\n"
mkdir -p diffs

echo "[test] no read"
mkdir -p noread/ && cd noread
touch no_read && chmod 000 no_read
test no_read ..
cd ..
echo -e "----------------\n"

echo "[Error Handling - 1] no permission directory"
mkdir -p no_perm
cd no_perm && touch a
chmod 111 .
test no_perm ..
cd ..
echo -e "----------------\n"

echo "[Error Handling - 2] empty directory"
mkdir -p empty
cd empty
test empty ..
cd ..
echo -e "----------------\n"

echo "[Error Handling - 3] max file name"
mkdir -p maxfile && cd maxfile
touch 123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345
test max ..
cd ..
echo -e "----------------\n"

echo "[Error Handling - 4] newline"
mkdir -p newline && cd newline
touch "a

"
test newline ..
cd ..
echo -e "----------------\n"

echo "[Error Handling - 5] many fiels"
mkdir manyfiles
cd manyfiles
touch {1..10000}
test newline ..
cd ..
sleep 5
rm -rf manyfiles
echo -e "----------------\n"

echo "[Simple] part1"
touch {1..10}
test simple1 .
echo -e "----------------\n"

echo "[Simple] part2"
touch 2
test simple2 .
echo -e "----------------\n"

echo "[SimpleCheck - 1] Symbolic link"
ln -s Makefile s_file
test symbolic .
echo -e "----------------\n"

echo "[SimpleCheck - 2] Hard link"
ln Makefile h_file
test hard .
echo -e "----------------\n"

echo "[SimpleCheck - 3] nsec same"
touch {5..10}
test nsec_same .
echo -e "----------------\n"

echo "[SimpleCheck - 4] minus timestamp"
touch -t 194201010000 3
test minustime .
echo -e "----------------\n"

echo "[SimpleCheck - 5] hidden file"
touch .test
test hidden .
echo -e "----------------\n"
