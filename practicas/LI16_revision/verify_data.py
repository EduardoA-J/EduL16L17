import csv
from pathlib import Path
p=Path(r'F:\BIG_DATA\pseudo_facebook_EduardoAntezana.csv\pseudo_facebook_EduardoAntezana.csv')
with p.open(encoding='utf-8-sig',newline='') as f:
    rows=list(csv.DictReader(f))
print('rows',len(rows),'cols',len(rows[0]) if rows else 0)
print('headers',list(rows[0]) if rows else [])
print('age>25',sum(int(r['age'])>25 for r in rows))
for g in ['female','male']:
    vals=[int(r['friend_count']) for r in rows if r['gender']==g]
    print('gender',g,'n',len(vals),'avg',sum(vals)/len(vals))
for label,cond in [('13-25',lambda a:13<=a<=25),('>35',lambda a:a>35)]:
    sub=[r for r in rows if cond(int(r['age']))]
    vals=[int(r['likes_received']) for r in sub]
    print('likes',label,'n',len(sub),'sum',sum(vals),'avg',sum(vals)/len(vals))
months={m:sum(int(r['dob_month'])==m for r in rows) for m in range(1,13)}
print('months',months,'sum',sum(months.values()))
for label,cond in [('13-25',lambda a:13<=a<=25),('>25',lambda a:a>25)]:
    sub=[r for r in rows if cond(int(r['age']))]
    m=sum(int(r['mobile_likes']) for r in sub); w=sum(int(r['www_likes']) for r in sub)
    morem=sum(int(r['mobile_likes'])>int(r['www_likes']) for r in sub); morew=sum(int(r['www_likes'])>int(r['mobile_likes']) for r in sub); eq=sum(int(r['www_likes'])==int(r['mobile_likes']) for r in sub)
    print('device',label,'mobile',m,'web',w,'persons',morem,morew,eq)
na_tenure=sum(r['tenure']=='NA' for r in rows); na_gender=sum(r['gender']=='NA' for r in rows)
print('NA',na_tenure,na_gender)
