with bifurb ( x1,y1,x2,y2,depth )
as
( 
  select convert(float,0),convert(float,0), convert(float,0),convert(float,1),1
  union all
  select x2,y2,x2+(x2-x1+y2-y1) *0.5, y2+(y2-y1-x2+x1) * 0.5,depth+1 from bifurb where depth <= 11
  union all
  select x2,y2,x2+(x2-x1-y2+y1) * 0.5, y2+(y2-y1+x2-x1) * 0.5,depth+1 from bifurb where depth <= 11
)
select
geometry::STGeomFromText('LINESTRING(' +
  convert(varchar,x1) + ' ' + convert(varchar,y1) + ',' +
  convert(varchar,x2) + ' ' + convert(varchar,y2) + ')',0)
  from bifurb 
  
