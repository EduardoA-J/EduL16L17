from zipfile import ZipFile
from pathlib import Path
from PIL import Image, ImageDraw
import io,re
src=Path(r'F:\BIG_DATA\LI16_Informe_EduardoAntezana.docx'); out=Path(r'F:\BIG_DATA\_review_li16\natural'); out.mkdir(parents=True,exist_ok=True)
z=ZipFile(src); names=sorted((n for n in z.namelist() if n.startswith('word/media/image')),key=lambda n:int(re.search(r'image(\d+)',n).group(1)))
files=[]
for n in names:
 i=int(re.search(r'image(\d+)',n).group(1)); im=Image.open(io.BytesIO(z.read(n))); p=out/f'image{i:02}.png'; p.write_bytes(z.read(n)); files.append(p)
thumb_w,thumb_h,cols=340,192,3; rows=(len(files)+cols-1)//cols; sheet=Image.new('RGB',(cols*thumb_w,rows*(thumb_h+32)),'white'); draw=ImageDraw.Draw(sheet)
for j,p in enumerate(files):
 im=Image.open(p).convert('RGB').resize((thumb_w,thumb_h)); x=(j%cols)*thumb_w; y=(j//cols)*(thumb_h+32); sheet.paste(im,(x,y+24)); draw.text((x+4,y+4),p.name,fill='black')
sheet.save(out.parent/'contact_natural.png'); print('natural images',len(files))
