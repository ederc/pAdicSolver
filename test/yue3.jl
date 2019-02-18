
using Hecke
include("../src/HeckeExt.jl")
include("../src/AlgebraicSolvers.jl")

# module aliasing
HKE = Main.HeckeExt
AS = Main.AlgebraicSolvers


function raw_sol_test(P,sol)
    return [p(X=>sol.entries[i,2:size(sol,2)]) for i in 1:size(sol,1),  p in P]
end

function rel_error(P,sol)
    return [p(X=>sol.entries[i,:]) for i in 1:size(sol,1),  p in P]
end

# For now, we need a fairly large prime. p=7 goes wrong fairly quickly.
# The critical case is p=89.
Qp = PadicField(101,6)
function Base.zero(X::Type{padic})
    return Qp(0)
end

X = AS.@Ring a c
n = length(X)

## Note: The system below was designed to be evil for p=89.
P = [
-43868231516999844828310246117515417801500080841*a^3*c^6-14193739651583395988549026156690505570333613*a^2*c^7-30039021941941114191228136228290512071*a*c^8+33663377792033017744226887592515669143875374629*c^9+218140786245837113636187114295137712556220*a^3*c^5-4803571350941276753640772686682730690096925177480*a^2*c^6-1554293189569099280698514653529033369057322820*a*c^7+79335303509881219070140601873773569248*c^8+61612684714890596535702840052230123260944622000*a^3*c^4+15804346117367097052900926597226818914548575*a^2*c^5-262995323783985824642885994787517663236568222391874*a*c^6+3386854908690700974767862912475753858068031*c^7+6949605236923474012066087830495962928689963662366220*a^3*c^3+4497435227777341303969153806394399970887259458710*a^2*c^4-8852053587686398660645630962544432064210832*a*c^5-5053423731789250183850058410463077976180950906*c^6+28002230144376087221113073375996637001763800*a^3*c^2+380490886721562717199546543003472735293678658221362720*a^2*c^3-11442722428309228625259185975815183384678636935*a*c^4-106883310491820893410524397296435647373563509*c^5+390427260501311028893782935985769171570535204250400*a^3*c+1807543973821151459601681109714793078219705880*a^2*c^2+13160272672064037459780293548760239810675312623980*a*c^3-14958863152531802838353607062178171869097292360*c^4+22019129232667898071219949603394302934060505868349941448*a^3-921230834227773352753612223284763972114641490136*a^2*c+92320095614012183729866108993575088463699839420*a*c^2+2791252453998582909434264681051736155100250453*c^3+85764855060933708583271149766523311550869440656*a^2-12984996526485031862389969187372278622362476918308*a*c-540616273396064328773158473602826256944278*c^2-7155425066412301125163535167805045836656*a-16858922679829200908838863721082479850156*c-9386546235222260481052779565448,-131604694550999534484930738352546253404500242523*a^4*c^5-42581218954750187965647078470071516711000839*a^3*c^6-90117065825823342573684408684871536213*a^2*c^7+100990133376099053232680662777547007431626123887*a*c^8+545351965614592784090467785737844281390550*a^4*c^4-15211309278122617107021919003915696447537523121030*a^3*c^5-4403765122345183882430306475747190278713451745*a^2*c^6-1192284012448673668813446920247832100862*a*c^7+1533238400556652944603822740805421083619547*c^8+123225369429781193071405680104460246521889244000*a^4*c^3+39554294105299231603749194839129605043765325*a^3*c^4-701321209557449679617709838761974150141665078678799*a^2*c^5+7434563342224863766180789692642093850490569*a*c^6+30744142471648542671409469055410169164377*c^7+10424407855385211018099131745743944393034945493549330*a^4*c^2+8995161212044348331658760801896433412872837661460*a^3*c^3-26786651349404493645155181574752486686200890*a^2*c^4-22740856521785636614391291031486479682065829432*a*c^5+4395605978355722088200057012597751049339594*c^6+28002230144376087221113073375996637001763800*a^4*c+634151477878292459464257839580801848262736583953861280*a^3*c^2-12272827144674455275519674161253537865943495295*a^2*c^3-534416725724809603241317445835705534903918415*a*c^4+9858614949477064528336678542708644229032175360*c^5+195213630250655514446891467992884585785267602125200*a^4+2295327257172125573002431243698474174212703090*a^3*c+23031217160812316755899121671277701273844197081370*a^2*c^2-82272984354585308304486861338035021954470825120*a*c^3+15711542403353964983077209150375355557467*c^4+921233368764418596389722177419679039707056295636*a^3+69383933092678226283069773696343289737840817800*a^2*c+6280343873864565322502994115331800840137326733*a*c^2+5536925305660608323305592020195268484009191499*c^3+3246249134676100943622625236560865698757863404612*a^2-814077935047706089820797867483911449816502*a*c+312341808373718968992707331349335563240575312705500*c^2+8429460585667813224582491611385229355168*a-1564768815220099692858933605100266756053288*c-968037959475710271990346119320616,-131604694550999534484930738352546253404500242523*a^5*c^4-42581218954750187965647078470071516711000839*a^4*c^5-90117065825823342573684408684871536213*a^3*c^6+100990133376099053232680662777547007431626123887*a^2*c^7+436281572491674227272374228590275425112440*a^5*c^3-16011904503421403953121519947783200824784270709620*a^4*c^4-4144650675983069922765068990907280450254935030*a^3*c^5-2622573935426990994837315646116984909468*a^2*c^6+3066476801113305889207645481610842167239094*a*c^7+73935221657868715842843408062676147913133546400*a^5*c^2+31678178333744576460196858548153730240927370*a^4*c^3-642878104258614089559971950453324216758567066720881*a^3*c^4+6403255320859025475533497396857531578233595*a^2*c^5+30744121801280723685419565119070746558185*a*c^6+2839578037384778343102515154099818258281603*c^7+4169763142154084407239652698297577757213978197419732*a^5*c+5397271181120408433227528394602440130382693843300*a^4*c^2-22295268447128946730085813615815358061364616*a^3*c^3-30321393155785822662184338793373939409066389256*a^2*c^4+131283731649778412105263424539642875938800*a*c^5+83089360162603097950977210439959972*c^6+5600446028875217444222614675199327400352760*a^5+279026650269696337251678345862557837433982072230271392*a^4*c+1536223742125087466431313529960590136699361933*a^3*c^2-587526897706275238538152678808192767275665915*a^2*c^3+12321296078577916141078891567140181102178046584*a*c^4+1595111566828830538159039750233194388887002*c^5+556622108104619937280636275536431054041140060*a^4+10967518951484401926402558034671137762494252940672*a^3*c-44875929570216204246890232437496067231555743124*a^2*c^2+10808669577218248036147294665808479324918*a*c^3+179909039301197074746950481442871918487881215884*c^4+23166374364080713832086964424814204289695280468*a^3+3140184950412193887330423261752984665778091084*a^2*c+4152370641767155825247943156913855105680956131*a*c^2+3299528813669915952867537686427163858683*c^3+407380559241838099305396758259437695140*a^2+156170904186872044268056280902722891052079656643708*a*c+6533649742045795364224857901970560603128052*c^2+87397722041909020972616273854597646164676*a+202762718605363758282640773126725745453772*c+113471837111652235055470625948896,-43868231516999844828310246117515417801500080841*a^6*c^3-14193739651583395988549026156690505570333613*a^5*c^4-30039021941941114191228136228290512071*a^4*c^5+33663377792033017744226887592515669143875374629*a^3*c^6+109070393122918556818093557147568856278110*a^6*c^2-5604166576240063599740373630550235067343672766070*a^5*c^3-1295178743206985321033277168689123540598806105*a^4*c^4-1350954619468436106953728123995379239358*a^3*c^5+1533238400556652944603822740805421083619547*a^2*c^6+12322536942978119307140568010446024652188924400*a^6*c+7928230345812441909348590306250944111710620*a^5*c^2-204552218485150234585148106478867729853470210433956*a^4*c^3+2355546887324862684120570616691191585811057*a^3*c^4-20670367818985989903936339422606192*a^2*c^5+2839578037384778343102515154099818258281603*a*c^6+347480261846173700603304391524798146434498183118311*a^6+899574272502367977909966718011170035506947514954*a^5*c-5075487319547213190794066748282242566408344*a^4*c^2-12633987293342081678436807634479369994114126846*a^3*c^3+43795514821629588981077069562521674372190*a^2*c^4+74380193188830562393568561567005008*a*c^5+25906924381837118941332479525084874207209084*c^6+25366059115672974226471129657732911296905792573249856*a^5+2161415528803034590819721818193319751197002168*a^4*c-160126092565769880831480436454241747808589687*a^3*c^2+2462681129035855378192645928911279713941420805*a^2*c^3+797607356382212140758389341013980573331108*a*c^4+905009115230276000773645967891511671*c^5+1096771655393070678999742018978026303772909158230*a^4+104142553153781837556466096132585660311708*a^3*c+1541222346531775563408359767158526654629*a^2*c^2+44977259775572733601357604945356862065800212294*a*c^3+1881751515415741757178600282651808673496*c^4+348910635432633342868382916765460897012899276*a^3+692277361168933026509110987223949432615953464*a^2*c+813826651180359868179951033080552506631*a*c^2+58390217351362602602225700260747411772*c^3+19521363025066844238881796241042603150655987981099*a^2+1633464323898361309884810153168112322256586*a*c+34171301806477732811263484791611188*c^2+50690678788197727275852922488197624645108*a+2120788637732538850449730620204428*c+32906832795292224569412548661220,131604694550999534484930738352546253404500242523*a^7*c^2+42581218954750187965647078470071516711000839*a^6*c^3+90117065825823342573684408684871536213*a^5*c^4-100990133376099053232680662777547007431626123887*a^4*c^5-218140786245837113636187114295137712556220*a^7*c+17613094954018977645320721835518209579277765886800*a^6*c^2+3626421783258842003434594021227460793337901600*a^5*c^3+5483153781383625646885053097855290526680*a^4*c^4-6132953602226611778415290963221684334478188*a^3*c^5-12322536942978119307140568010446024652188924400*a^7-15873832216377479407295931950926911326378795*a^6*c+613656863147959522204126945711811068547195772421760*a^5*c^2-9424719365571551496665433052290223388089297*a^4*c^3+61488408965503999258758361728856873965906*a^3*c^4-17037468224308670058615090924598909549689618*a^2*c^5-899603348151334550282012036921933382616779389358*a^6+7724681786351656507697752695871412980883496*a^5*c+45482643477164840074150647748065488274691651626*a^4*c^2-17320267701383772947941572337903407034191856*a^3*c^3-394026157290348161016959476164300264*a^2*c^4-310883092582045427295989754301018490486509008*a*c^5-4488852000879114511691541273474310398646976008*a^5+266611498075207802812968971250048889114425706*a^4*c+2475831856484048009148067849948887796667112783*a^3*c^2-798764960184269503833349323516609292005859*a^2*c^3-11643849228818975024369696500692949979*a*c^4-4480321692955513513275414585191065848827*c^5-14958925029101056620116435179102223166228118380*a^4-3684668707441146799789559185964292291800*a^3*c+269863559458649447350014243641317228931979425060*a^2*c^2-15711966388382728450731954962679122757968*a*c^3-94641406442507881610019149747404450748*c^4-692924152928803102678823617726477634825865840*a^3+217328637252589516104270024096101216825*a^2*c+11667245568765746258799832986628539136083950*a*c^2-13262008601359714346028451608334917931247*c^3-3267133505754830978401189878693917336742038*a^2+81949607791589648989483776168782448126208*a*c+2474623411661580894661718155535008396766*c^2-11512027952393560627512741695798889904870224*a-479292073610781306677130854232066728*c-14946510397924183015084850500476752,131604694550999534484930738352546253404500242523*a^8*c+42581218954750187965647078470071516711000839*a^7*c^2+90117065825823342573684408684871536213*a^6*c^3-100990133376099053232680662777547007431626123887*a^5*c^4-109070393122918556818093557147568856278110*a^8+18413690179317764491420322779385713956524513475390*a^7*c+3367307336896728043769356536387550964879384885*a^6*c^2+6913443704361942972908921823724443335286*a^5*c^3-7666192002783264723019113704027105418097735*a^4*c^4-7945601870565037497947341644675967214668175*a^7+642878727336140544906019829278947853718922490080557*a^6*c-13477491431649915808444661003507477470201973*a^5*c^2+153720919061920903216946384640445071883805*a^4*c^3-28395780373847783431025151540998182582816030*a^3*c^4+1934377832668081871685882202914231287441366*a^6+53063518729859544119086117713642571158912050868*a^5*c-64622280486989150750327898785049058452483610*a^4*c^2-569618592412854912787512638210950800*a^3*c^3-777207731455113568239974385752546226216272520*a^2*c^4+53109993317109638526944513415698951672195522*a^5+12339707115102062622414194159224240524958599025*a^4*c+3983280222256711321994536110504426851033925*a^3*c^2-31068972687186595098639103466719399765*a^2*c^3-22401608464777567566377072925955329244135*a*c^4-5109579842976766472681327807471306938038*a^4+854567937651191196047400232482731666928965519992*a^3*c-18841053735032974165208305472370534593771*a^2*c^2-520527540003716806038905407516157143682*a*c^3+4370405087966492465015671194456574552515*c^4-1074268091783001619990571644836263573231*a^3+35002962237857128608984435204811114039038131*a^2*c-79571270944664569697495121863894790822587*a*c^2-8132081950803834130380530906258377*c^3+40872591786383644556429945857413980075890*a^2+10517185519058795038499418464992217948510*a*c+2453845373701278929557451164728695078156*c^2-962635383997076626947617917425700980*a+276910942514611313319987496074048288885889348*c-1542234711433011996527672364047031664,43868231516999844828310246117515417801500080841*a^9+14193739651583395988549026156690505570333613*a^8*c+30039021941941114191228136228290512071*a^7*c^2-33663377792033017744226887592515669143875374629*a^6*c^3+6404761801538850445839974574417739444590420354660*a^8+1036064296844871361368039683849213712140289390*a^7*c+2781244542446753432977596849864532047964*a^6*c^2-3066476801113305889207645481610842167239094*a^5*c^3+233774082673331257287040990046004515025196928092753*a^7-6408318953403226995899798567908445667923733*a^6*c+92232530766784722944177926847927620524091*a^5*c^2-14197890186923891715512575770499091291408015*a^4*c^3+20214889473589431170165979062185285169267142204*a^6-51653926061954580656443274174328802940436928*a^5*c-241263461337564778606713074740700580*a^4*c^2-518138487636742378826649590501697484144181680*a^3*c^3+4935882861002229283956231240762064840579100235*a^5+3983795951934680038783230769478260639909995*a^4*c-22018881534883835090902643787804283055*a^3*c^2-22401608464777567566377072925955329244135*a^2*c^3+359818079003665857052329555066099540321435748224*a^4+3242694163532858779671158215618371132378*a^3*c-567848047794894204027715066295292033624*a^2*c^2+8740810175932984930031342388913149105030*a*c^3+15557261005493718844481516724689359210854371*a^3-39785201286827303092608092306169709164851*a^2*c-12203387318906846473573468333970523*a*c^2+159500842677096810748278517532437095154723*c^3+4949280788812186515734122189499709430400*a^2+2453845503113790209245905917947124623136*a*c+2784627401240958210769372095909408*c^2+138455471257311680802971850858048225914049064*a+5792495790970202408746445350020166576*c+179762084351356392083445790701949104
];


P = [p*Qp(1) for p in P];


#matlist, F, B, N, Nr, R = AS.solve_macaulay(P,X,15);
sol = AS.solve_macaulay(P,X,15)

# println("\n-- sol ")
# println(sol,"\n")

# Er = rel_error(P,sol)
# println("-- Rel error: ")
# display(Er)
# println()


