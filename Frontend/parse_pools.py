with open(r'C:\Users\JISHNU PG\Music\Claude\hermes_extracted\resources.arsc', 'rb') as f:
    data = f.read()

i = 470248
type_strings_offset = int.from_bytes(data[i+138:i+142], 'little')
key_strings_offset = int.from_bytes(data[i+142:i+146], 'little')

print('typeStrings offset: {}, keyStrings offset: {}'.format(type_strings_offset, key_strings_offset))

# Type strings pool
type_pool_offset = i + type_strings_offset
print('Type pool at offset: {}'.format(type_pool_offset))
if type_pool_offset + 28 < len(data):
    pool_type = int.from_bytes(data[type_pool_offset:type_pool_offset+4], 'little')
    pool_header_size = int.from_bytes(data[type_pool_offset+4:type_pool_offset+6], 'little')
    pool_size = int.from_bytes(data[type_pool_offset+6:type_pool_offset+10], 'little')
    string_count = int.from_bytes(data[type_pool_offset+8:type_pool_offset+12], 'little')
    style_count = int.from_bytes(data[type_pool_offset+12:type_pool_offset+16], 'little')
    flags = int.from_bytes(data[type_pool_offset+16:type_pool_offset+20], 'little')
    strings_start = int.from_bytes(data[type_pool_offset+20:type_pool_offset+24], 'little')
    styles_start = int.from_bytes(data[type_pool_offset+24:type_pool_offset+28], 'little')
    print('  type=0x{:08x}, headerSize={}, size={}'.format(pool_type, pool_header_size, pool_size))
    print('  stringCount={}, styleCount={}, flags={}'.format(string_count, style_count, flags))
    print('  stringsStart={}, stylesStart={}'.format(strings_start, styles_start))
    
    for j in range(min(string_count, 100)):
        if type_pool_offset + 28 + j*4 + 4 > len(data):
            break
        offset = int.from_bytes(data[type_pool_offset+28+j*4:type_pool_offset+28+j*4+4], 'little')
        str_offset = type_pool_offset + strings_start + offset
        if str_offset + 2 < len(data):
            str_len = int.from_bytes(data[str_offset:str_offset+2], 'little')
            if str_len < 1000:
                str_data = data[str_offset+2:str_offset+2+str_len*2]
                try:
                    decoded = str_data.decode('utf-16le')
                    if 'string' in decoded.lower() or 'claude' in decoded.lower() or 'hermes' in decoded.lower():
                        print('    [{}] -> "{}"'.format(j, decoded[:80]))
                except:
                    pass

# Key strings pool
key_pool_offset = i + key_strings_offset
print('\nKey pool at offset: {}'.format(key_pool_offset))
if key_pool_offset + 28 < len(data):
    pool_type = int.from_bytes(data[key_pool_offset:key_pool_offset+4], 'little')
    pool_header_size = int.from_bytes(data[key_pool_offset+4:key_pool_offset+6], 'little')
    pool_size = int.from_bytes(data[key_pool_offset+6:key_pool_offset+10], 'little')
    string_count = int.from_bytes(data[key_pool_offset+8:key_pool_offset+12], 'little')
    style_count = int.from_bytes(data[key_pool_offset+12:key_pool_offset+16], 'little')
    flags = int.from_bytes(data[key_pool_offset+16:key_pool_offset+20], 'little')
    strings_start = int.from_bytes(data[key_pool_offset+20:key_pool_offset+24], 'little')
    styles_start = int.from_bytes(data[key_pool_offset+24:key_pool_offset+28], 'little')
    print('  type=0x{:08x}, headerSize={}, size={}'.format(pool_type, pool_header_size, pool_size))
    print('  stringCount={}, styleCount={}, flags={}'.format(string_count, style_count, flags))
    print('  stringsStart={}, stylesStart={}'.format(strings_start, styles_start))
    
    # Look for app_name (should be around index 0x6f = 111)
    for j in range(min(string_count, 200)):
        if key_pool_offset + 28 + j*4 + 4 > len(data):
            break
        offset = int.from_bytes(data[key_pool_offset+28+j*4:key_pool_offset+28+j*4+4], 'little')
        str_offset = key_pool_offset + strings_start + offset
        if str_offset + 2 < len(data):
            str_len = int.from_bytes(data[str_offset:str_offset+2], 'little')
            if str_len < 1000:
                str_data = data[str_offset+2:str_offset+2+str_len*2]
                try:
                    decoded = str_data.decode('utf-16le')
                    if j == 0x6f or 'app_name' in decoded or 'Claude' in decoded or 'Hermes' in decoded:
                        print('    [{}] (0x{:x}) -> "{}"'.format(j, j, decoded[:80]))
                except:
                    pass