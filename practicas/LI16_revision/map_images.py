from docx import Document
from pathlib import Path
from PIL import Image
p=Path(r'F:\BIG_DATA\LI16_Informe_EduardoAntezana.docx'); d=Document(p)
for i,para in enumerate(d.paragraphs):
    rels=para._p.xpath('.//a:blip/@r:embed')
    if rels:
        print('PARA',i,'TEXT',para.text)
        for r in rels:
            target=d.part.related_parts[r].partname
            print('  IMAGE',target)
