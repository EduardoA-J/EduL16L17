from docx import Document
from docx.shared import Inches
from pathlib import Path
p=Path(r'F:\BIG_DATA\LI16_Informe_EduardoAntezana.docx'); d=Document(p)
for i,s in enumerate(d.sections):
 print('SECTION',i,'page_inches',round(s.page_width/Inches(1),2),round(s.page_height/Inches(1),2),'margins',round(s.top_margin/Inches(1),2),round(s.bottom_margin/Inches(1),2),round(s.left_margin/Inches(1),2),round(s.right_margin/Inches(1),2))
for i,sh in enumerate(d.inline_shapes,1): print('IMAGE',i,'inches',round(sh.width/Inches(1),2),round(sh.height/Inches(1),2))
print('PAGE_BREAKS',sum(1 for p in d.paragraphs for r in p.runs if 'w:type="page"' in r._r.xml))
