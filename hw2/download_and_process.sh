mkdir -p datasets/txt
mkdir -p datasets/csv

for num in {1..9}
do
    (echo a"${num}"a is downloading;
    wget -q -t inf https://www.csie.ntu.edu.tw/~cjlin/libsvmtools/datasets/binary/a"${num}"a -P ./datasets/txt/;
    echo a"${num}"a downloaded and now is reading;
    python3 parse.py ./datasets/txt/a"${num}"a ./datasets/csv;
    echo a"${num}"a is read
    ) &
done

for process in `jobs -p`
do
    wait $process
done

echo all files downloaded
