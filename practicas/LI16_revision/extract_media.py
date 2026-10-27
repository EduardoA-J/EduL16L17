from zipfile import ZipFile
from pathlib import Path
from PIL import Image
import io
src=Path(r'F:\BIG_DATA\LI16_Informe_EduardoAntezana.docx')
out=Path(r'F:\BIG_DATA\_review_li16\embedded')
out.mkdir(parents=True, exist_ok=True)
z=ZipFile(src)
files=sorted(x for x in z.namelist() if x.startswith('word/media/'))
print('images:', len(files))
for i,n in enumerate(files,1):
    b=z.read(n)
    im=Image.open(io.BytesIO(b))
    ext=im.format.lower()
    p=out/f'evidence_{i:02}.{ext}'
    p.write_bytes(b)
    print(i,n,len(b),im.size,im.format)
