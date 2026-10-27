from pathlib import Path
from PIL import Image, ImageDraw
folder=Path(r'F:\BIG_DATA\_review_li16\embedded')
files=sorted(folder.glob('evidence_*.png'))
thumb_w,thumb_h=340,192
cols=3
rows=(len(files)+cols-1)//cols
sheet=Image.new('RGB',(cols*thumb_w,rows*(thumb_h+32)), 'white')
draw=ImageDraw.Draw(sheet)
for i,p in enumerate(files):
    im=Image.open(p).convert('RGB').resize((thumb_w,thumb_h))
    x=(i%cols)*thumb_w; y=(i//cols)*(thumb_h+32)
    sheet.paste(im,(x,y+24)); draw.text((x+4,y+4),p.name,fill='black')
out=folder.parent/'contact.png'; sheet.save(out); print(out)
