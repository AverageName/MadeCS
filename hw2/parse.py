import pandas as pd
import sys
from os.path import basename
from sklearn.datasets import load_svmlight_file

if __name__ == '__main__':
    if len(sys.argv) != 3:
        print('Error usage. Please use python3 parse.py filename save_dir')
    file_path, save_dir = sys.argv[1], sys.argv[2]
    f = load_svmlight_file(file_path)
    df = pd.DataFrame(f[0].toarray()).astype(int)
    df.columns += 1
    df['target'] = f[1]
    df.to_csv(f'{save_dir}/{basename(file_path)}.csv', index=False)

