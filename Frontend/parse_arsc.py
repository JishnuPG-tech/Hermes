with open(r'C:\Users\JISHNU PG\Music\Claude\resources.arsc', 'rb') as f:
    data = f.read()

# Find string pool chunk (type 0x00000001)
for i in range(0, min(2000, len(data)), 4):
    chunk_type = int.from_bytes(data[i:i+4], 'little')
    if chunk_type == 0x00000001:
        header_size = int.from_bytes(data[i+4:i+6], 'little')
        chunk_size = int.from_bytes(data[i+6:i+10], 'little')
        print(f'String pool at offset {i}: headerSize={header_size}, chunkSize={chunk_size}')
        string_count = int.from_bytes(data[i+10:i+14], 'little')
        style_count = int.from_bytes(data[i+14:i+18], 'little')
        flags = int.from_bytes(data[i+18:i+22], 'little')
        strings_start = int.from_bytes(data[i+22:i+26], 'little')
        styles_start = int.from_bytes(data[i+26:i+30], 'little')
        print(f'  stringCount={string_count}, styleCount={style_count}, flags={flags}')
        print(f'  stringsStart={strings_start}, stylesStart={styles_start}')
        for j in range(min(20, string_count)):
            offset = int.from_bytes(data[i+30+j*4:i+30+j*4+4], 'little')
            abs_offset = i + strings_start + offset
            if abs_offset < len(data):
                str_len = int.from_bytes(data[abs_offset:abs_offset+2], 'little')
                str_data = data[abs_offset+2:abs_offset+2+str_len*2]
                try:
                    decoded = str_data.decode('utf-16le')
                    print(f'    [{j}] offset={offset} len={str_len} -> "{decoded[:80]}"')
                except:
                    print(f'    [{j}] offset={offset} len={str_len} -> <undecodable>')
        break