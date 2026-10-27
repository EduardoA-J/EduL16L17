from pathlib import Path
from PIL import Image,ImageDraw
folder=Path(r'F:\BIG_DATA\li17\evidencias'); files=sorted(folder.glob('*.png'))
thumb_w,thumb_h,cols=380,214,3; rows=(len(files)+cols-1)//cols
sheet=Image.new('RGB',(thumb_w*cols,(thumb_h+34)*rows),'white'); draw=ImageDraw.Draw(sheet)
for i,p in enumerate(files):
 try: im=Image.open(p).convert('RGB').resize((thumb_w,thumb_h))
 except Exception: continue
 x=(i%cols)*thumb_w; y=(i//cols)*(thumb_h+34); sheet.paste(im,(x,y+24)); draw.text((x+4,y+4),p.name,fill='black')
out=folder.parent/'contact_review.png'; sheet.save(out); print('images',len(files),out)
