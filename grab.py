#!/usr/bin/python
import argparse, urllib2, cookielib, Cookie, os, re
from bs4 import BeautifulSoup
from datetime import datetime

parser = argparse.ArgumentParser()
parser.add_argument("-o","--out",
  help="output to file instead of stdout", type=argparse.FileType('w', 0))
parser.add_argument("-i","--inter",
  help="write intermediate downloaded files", action="store_true")
parser.add_argument("address", help="\"required address\"")
args = parser.parse_args()
args.address = args.address.replace(' ','-')
# url
url = 'http://www.zillow.com/homes/'+args.address+'_rb/'

p = cookielib.DefaultCookiePolicy(rfc2965=True, strict_ns_domain=cookielib.DefaultCookiePolicy.DomainStrict,
    blocked_domains=[])
cj = cookielib.MozillaCookieJar(os.path.join(os.path.expanduser("~"), "cookiejar.txt"))
cj.load()

b = cookielib.Cookie (version=0, name='F5P', value="1931528202.0.0000" , port=None, port_specified=False, domain='www.zillow.com', domain_specified=False, domain_initial_dot=False, path='/', path_specified=True, secure=False, expires=None, discard=True, comment=None, comment_url=None, rest={'HttpOnly': None}, rfc2109=False)
c = cookielib.Cookie (version=0, name='__utma', value="120252567.1414894437.1397053982.1397053982.1397054015.2" , port=None, port_specified=False, domain='.zillow.com', domain_specified=False, domain_initial_dot=False, path='/', path_specified=True, secure=False, expires=None, discard=True, comment=None, comment_url=None, rest={'HttpOnly': None}, rfc2109=False)
d = cookielib.Cookie (version=0, name='__utmb', value="120252567.18.9.1397054686156" , port=None, port_specified=False, domain='.zillow.com', domain_specified=False, domain_initial_dot=False, path='/', path_specified=True, secure=False, expires=None, discard=True, comment=None, comment_url=None, rest={'HttpOnly': None}, rfc2109=False)
e = cookielib.Cookie (version=0, name='__utmc', value="120252567" , port=None, port_specified=False, domain='.zillow.com', domain_specified=False, domain_initial_dot=False, path='/', path_specified=True, secure=False, expires=None, discard=True, comment=None, comment_url=None, rest={'HttpOnly': None}, rfc2109=False)
f = cookielib.Cookie (version=0, name='__utmv', value="120252567.|1=Guid=79c198e1113142548640f2481ac52c4e%2FX1-ZUzpbclz5gehop_3wgux=1^22=AccountCreationDate=2014-04-09=1^36=A%2FB%20Test%2011=iOSBALPhoneRequirements.CONTROL=1^37=A%2FB%20Test%2012=TrafficAutoAccountCreationMessaging.CONTROL=1^38=A%2FB%20Test%2013=RentalsActionButtonText.CONTACT_MANAGER=1^39=A%2FB%20Test%2014=RentalFilterUI.CONTROL=1^40=A%2FB%20Test%2015=TENgageLockedContentOnHDP.POP_OVER=1^41=A%2FB%20Test%201=PPL_Reg_Cleanup.CONTROL=1^42=A%2FB%20Test%202=TrafficCreateAccountOnMobileAppContact.CREATE_ACCOUNT=1^43=A%2FB%20Test%203=SHO_MAGIC_CARPET.CONTROL=1^44=A%2FB%20Test%204=MortgageModernCalculators.MODERN_UPSELL_ZMM=1^45=A%2FB%20Test%205=SELTablessLandingPage.CONTROL=1^46=A%2FB%20Test%206=MortgageShoppingWizard.HAS_CHOICE=1^47=A%2FB%20Test%207=LocalStorage.CONTROL=1^48=A%2FB%20Test%208=BALadjusted.CONTROL=1^49=A%2FB%20Test%209=RentalsVerifiedBadge.VERIFIED_BADGE_ON=1^50=A%2FB%20Test%2010=MobileWebHomepageButtons.FOR_SALE_FIRST=1" , port=None, port_specified=False, domain='.zillow.com', domain_specified=False, domain_initial_dot=False, path='/', path_specified=True, secure=False, expires=None, discard=True, comment=None, comment_url=None, rest={'HttpOnly': None}, rfc2109=False)
g = cookielib.Cookie (version=0, name='__utmz', value="120252567.1397054015.2.2.utmcsr=google|utmccn=(organic)|utmcmd=organic|utmctr=(not%20provided)" , port=None, port_specified=False, domain='.zillow.com', domain_specified=False, domain_initial_dot=False, path='/', path_specified=True, secure=False, expires=None, discard=True, comment=None, comment_url=None, rest={'HttpOnly': None}, rfc2109=False)
h = cookielib.Cookie (version=0, name='search', value="5|1399646172544%7Crect%3D43.190503%252C-85.94236%252C43.18845%252C-85.946356%26zm%3D17%26rid%3D40501%26disp%3Dmap%26mdm%3Dauto%26p%3D1%26z%3D1%26fs%3D1%26fr%3D1%26mmm%3D1%26rs%3D0%26ah%3D0%09%01%09%09%09%092%090%09US_" , port=None, port_specified=False, domain='.zillow.com', domain_specified=False, domain_initial_dot=False, path='/', path_specified=True, secure=False, expires=None, discard=True, comment=None, comment_url=None, rest={'HttpOnly': None}, rfc2109=False)
i = cookielib.Cookie (version=0, name='userid', value="X|2|68ac67125b207d1%7C4%7CmVS3Clc2sjYmrnJG8vJzlSw_kkJcTwtt0I275yBuvDo%3D" , port=None, port_specified=False, domain='.zillow.com', domain_specified=False, domain_initial_dot=False, path='/', path_specified=True, secure=False, expires=None, discard=True, comment=None, comment_url=None, rest={'HttpOnly': None}, rfc2109=False)
j = cookielib.Cookie (version=0, name='zguid', value="21|%5B%2279c198e1-1131-4254-8640-f2481ac52c4e%22%2C%22000000%22%2C%22%5Cu0000%5Cu0000%5Cu0000%5Cu0000%5Cu0000%5Cu0000%5Cu0000%5Cu0000%5Cu0000%5Cu0000%5Cu0000%5Cu0000%5Cu0000%5Cu0000%5Cu0000%5Cu0000%5Cu0000%5Cu0000%5Cu0000%5Cu0000%5Cu0000%5Cu0000%5Cu0000%5Cu0000%5Cu0000%5Cu0000%5Cu0000%22%2C%22false%40false%40false%40false%400%400%400%400%400%22%2C%220%22%2C%220%22%2C%220%22%2C%2210%22%2C%220%22%2C%220%400%400%400%400%400%22%2C%22%22%5D" , port=None, port_specified=False, domain='.zillow.com', domain_specified=False, domain_initial_dot=False, path='/', path_specified=True, secure=False, expires=None, discard=True, comment=None, comment_url=None, rest={'HttpOnly': None}, rfc2109=False)
cj.set_cookie(b)
cj.set_cookie(c)
cj.set_cookie(d)
cj.set_cookie(e)
cj.set_cookie(f)
cj.set_cookie(g)
cj.set_cookie(h)
cj.set_cookie(i)
cj.set_cookie(j)

opener = urllib2.build_opener(urllib2.HTTPCookieProcessor(cj))
r = opener.open(url)

html = r.read()

if args.inter:
  now=datetime.today()
  firstname = now.strftime("%Y%m%dT%I%M%S-1.html")
  f = open(firstname,'w') 
  f.write(html)
  f.close()

# got first page, find the zpid
inewid = re.search("(zpid_)([0-9]+)", html)
if inewid:

  zpid = inewid.group(2)
  #print "inewid is "+ zpid

  # open second page
  r = opener.open("http://www.zillow.com/homedetails/"+zpid+"_zpid/")

  # close the cookie jar
  cj.save(ignore_expires=True, ignore_discard=True)
  
  html = r.read()
  
  if args.inter:
    secondname = now.strftime("%Y%m%dT%I%M%S-2.html")
    f = open(secondname,'w') 
    f.write(html)
    f.close()

  soup=BeautifulSoup(html)
  
  table = soup.table

  if args.out:
    f = open(args.out.name,'w')

  for row in table.findAll('tr')[1:]:
    col = row.findAll('td')
    date = col[0].string
    action = col[1].string
    amount = col[2].string
    desc = col[3].string
    record = (date, action, amount, desc)
    if args.out:
      f.writelines("\t".join(field or "" for field in record)+'\n')
    else:
      print "\t".join(field or "" for field in record)
  if args.out:
    f.close()
  
