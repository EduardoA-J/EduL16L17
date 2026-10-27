from docx import Document
p=r'F:\BIG_DATA\LI17_Informe_EduardoAntezana.docx'; d=Document(p)
for i,para in enumerate(d.paragraphs):
 rels=para._p.xpath('.//a:blip/@r:embed')
 if rels:
  print('PARA',i,'TEXT',para.text)
  for r in rels: print(' IMAGE',d.part.related_parts[r].partname)
