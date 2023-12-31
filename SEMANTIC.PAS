{ @author: Sylvain Maltais (support@gladir.com)
  @created: 2023
  @website(https://www.gladir.com/CODER/LETTRESLIB-TP)
  @abstract(Target: Turbo Pascal 7, Free Pascal 3.2)
}

Unit SEMANTIC;

INTERFACE

Type
 TitleType=(Mademoiselle,Maitre,Madame,Monsieur,
            Docteur,Docteure,Monseigneur,NoGender,Unknown);

Function FindPrefix(Wd:String;Var PrefixName,Sens,Origin:String):Boolean;
Function FindSuffix(Wd:String;Var SuffixName,Sens,Origin:String):Boolean;
Function NameToTitle(Name:String):TitleType;

IMPLEMENTATION

Uses Strings;

Function Left(Const S:String;L:Byte):String;Begin
 Left:=Copy(S,1,L);
End;

Function Right(Const S:String;L:Byte):String;Begin
 Right:=Copy(S,Length(S)-L+1,L);
End;

Function StrToUpper(S:String):String;
Var
 I:Byte;
Begin
 For I:=1 to Length(S)do Begin
  If S[I] in['a'..'z']Then S[I]:=Chr(Ord(S[I])-32);
 End;
 StrToUpper:=S;
End;

Function FindPrefix(Wd:String;Var PrefixName,Sens,Origin:String):Boolean;
Type
 PrefixRec=Record
  PrefixName:String[10];
  Sens:String[30];
  Origin:(Grecque,Latine,Francais);
 End;
Const
 PrefixList:Array[0..369]of PrefixRec=(
  (PrefixName:'acanth';Sens:'�pine';Origin:Grecque),
  (PrefixName:'acro';Sens:'�lev�';Origin:Grecque),
  (PrefixName:'actino';Sens:'rayon';Origin:Grecque),
  (PrefixName:'ad�no';Sens:'glande';Origin:Grecque),
  (PrefixName:'a�ro';Sens:'air';Origin:Grecque),
  (PrefixName:'agro';Sens:'champ';Origin:Grecque),
  (PrefixName:'allo';Sens:'autre';Origin:Grecque),
  (PrefixName:'amphibi';Sens:'autour ou doublement';Origin:Grecque),
  (PrefixName:'ana';Sens:'de bas en haut; en arri�re, � rebours';Origin:Grecque),
  (PrefixName:'andro';Sens:'homme';Origin:Grecque),
  (PrefixName:'an�mo';Sens:'vent';Origin:Grecque),
  (PrefixName:'angi';Sens:'vaisseau; capsule';Origin:Grecque),
  (PrefixName:'anth';Sens:'fleur';Origin:Grecque),
  (PrefixName:'anthrac';Sens:'charbon';Origin:Grecque),
  (PrefixName:'anthropo';Sens:'homme';Origin:Grecque),
  (PrefixName:'anti';Sens:'contre';Origin:Grecque),
  (PrefixName:'ap';Sens:'hors de; � partir de; loin de';Origin:Grecque),
  (PrefixName:'arch�o';Sens:'ancien';Origin:Grecque),
  (PrefixName:'arch';Sens:'au plus haut degr�; commandant';Origin:Grecque),
  (PrefixName:'arithm';Sens:'nombre';Origin:Grecque),
  (PrefixName:'art�rio';Sens:'arri�re';Origin:Grecque),
  (PrefixName:'arthr';Sens:'arthiculation';Origin:Grecque),
  (PrefixName:'ast�r';Sens:'astre, �toile';Origin:Grecque),
  (PrefixName:'astro';Sens:'astre, �toile';Origin:Grecque),
  (PrefixName:'auto';Sens:'de soi-m�me';Origin:Grecque),
  (PrefixName:'bact�ri';Sens:'b�ton';Origin:Grecque),
  (PrefixName:'baro';Sens:'pesant';Origin:Grecque),
  (PrefixName:'bary';Sens:'lourd';Origin:Grecque),
  (PrefixName:'biblio';Sens:'livre';Origin:Grecque),
  (PrefixName:'bio';Sens:'vie';Origin:Grecque),
  (PrefixName:'blastro';Sens:'germe';Origin:Grecque),
  (PrefixName:'bl�phar';Sens:'paupi�re';Origin:Grecque),
  (PrefixName:'brachy';Sens:'court';Origin:Grecque),
  (PrefixName:'brady';Sens:'lent';Origin:Grecque),
  (PrefixName:'brom';Sens:'puanteur';Origin:Grecque),
  (PrefixName:'bact�ri';Sens:'b�ton';Origin:Grecque),
  (PrefixName:'bronch';Sens:'bronches';Origin:Grecque),
  (PrefixName:'bryo';Sens:'mousse';Origin:Grecque),
  (PrefixName:'butyr';Sens:'beurre';Origin:Grecque),
  (PrefixName:'cach';Sens:'mauvais';Origin:Grecque),
  (PrefixName:'caco';Sens:'mauvais';Origin:Grecque),
  (PrefixName:'calli';Sens:'beau';Origin:Grecque),
  (PrefixName:'carcin';Sens:'cancer';Origin:Grecque),
  (PrefixName:'cardi';Sens:'coeur';Origin:Grecque),
  (PrefixName:'cata';Sens:'de haut en bas, en dessous';Origin:Grecque),
  (PrefixName:'c�n';Sens:'commun';Origin:Grecque),
  (PrefixName:'c�phal';Sens:'t�te';Origin:Grecque),
  (PrefixName:'chalco';Sens:'cuivre';Origin:Grecque),
  (PrefixName:'ch�ir';Sens:'main';Origin:Grecque),
  (PrefixName:'chir';Sens:'main';Origin:Grecque),
  (PrefixName:'chlor';Sens:'vert';Origin:Grecque),
  (PrefixName:'chol';Sens:'bile';Origin:Grecque),
  (PrefixName:'chondr';Sens:'cartilage';Origin:Grecque),
  (PrefixName:'chrom';Sens:'temps';Origin:Grecque),
  (PrefixName:'chron';Sens:'temps';Origin:Grecque),
  (PrefixName:'chrys';Sens:'or';Origin:Grecque),
  (PrefixName:'cin�mat';Sens:'mouvement';Origin:Grecque),
  (PrefixName:'cin�';Sens:'creux';Origin:Grecque),
  (PrefixName:'cin�t';Sens:'creux';Origin:Grecque),
  (PrefixName:'coel';Sens:'creux';Origin:Grecque),
  (PrefixName:'coeli';Sens:'ventre';Origin:Grecque),
  (PrefixName:'conch';Sens:'coquille';Origin:Grecque),
  (PrefixName:'copro';Sens:'excr�ment';Origin:Grecque),
  (PrefixName:'cosm';Sens:'monde';Origin:Grecque),
  (PrefixName:'cosmo';Sens:'monde';Origin:Grecque),
  (PrefixName:'cryo';Sens:'froid';Origin:Grecque),
  (PrefixName:'crypt';Sens:'cach�';Origin:Grecque),
  (PrefixName:'crypto';Sens:'cach�';Origin:Grecque),
  (PrefixName:'cyan';Sens:'bleu';Origin:Grecque),
  (PrefixName:'cyano';Sens:'bleu';Origin:Grecque),
  (PrefixName:'cyan';Sens:'bleu';Origin:Grecque),
  (PrefixName:'cyber';Sens:'gouverner';Origin:Grecque),
  (PrefixName:'cycl';Sens:'cercle';Origin:Grecque),
  (PrefixName:'cyclo';Sens:'cercle';Origin:Grecque),
  (PrefixName:'cyto';Sens:'cellule';Origin:Grecque),
  (PrefixName:'dactyl';Sens:'doigt';Origin:Grecque),
  (PrefixName:'dactylo';Sens:'doigt';Origin:Grecque),
  (PrefixName:'d�ca';Sens:'dix';Origin:Grecque),
  (PrefixName:'d�mo';Sens:'peuple';Origin:Grecque),
  (PrefixName:'d�m';Sens:'peuple';Origin:Grecque),
  (PrefixName:'derm';Sens:'peau';Origin:Grecque),
  (PrefixName:'dermato';Sens:'s�par� de; � travers';Origin:Grecque),
  (PrefixName:'dia';Sens:'s�par� de; � travers';Origin:Grecque),
  (PrefixName:'didact';Sens:'enseigner';Origin:Grecque),
  (PrefixName:'diplo';Sens:'double';Origin:Grecque),
  (PrefixName:'di';Sens:'s�par� de; � travers';Origin:Grecque),
  (PrefixName:'dod�ca';Sens:'douze';Origin:Grecque),
  (PrefixName:'dolicho';Sens:'long';Origin:Grecque),
  (PrefixName:'dynamo';Sens:'force';Origin:Grecque),
  (PrefixName:'dynam';Sens:'force';Origin:Grecque),
  (PrefixName:'dys';Sens:'difficult�, mauvais �tat';Origin:Grecque),
  (PrefixName:'�chin';Sens:'h�risson';Origin:Grecque),
  (PrefixName:'ecto';Sens:'en dehors';Origin:Grecque),
  (PrefixName:'electro';Sens:'ambre jaune';Origin:Grecque),
  (PrefixName:'electr';Sens:'ambre jaune';Origin:Grecque),
  (PrefixName:'embryo';Sens:'foetus';Origin:Grecque),
  (PrefixName:'en';Sens:'dans';Origin:Grecque),
  (PrefixName:'enc�phal';Sens:'cerveau';Origin:Grecque),
  (PrefixName:'endo';Sens:'� l''int�rieur';Origin:Grecque),
  (PrefixName:'end';Sens:'� l''int�rieur';Origin:Grecque),
  (PrefixName:'ent�ro';Sens:'entrailles';Origin:Grecque),
  (PrefixName:'ent�r';Sens:'entrailles';Origin:Grecque),
  (PrefixName:'entomo';Sens:'insecte';Origin:Grecque),
  (PrefixName:'�o';Sens:'aurore';Origin:Grecque),
  (PrefixName:'�pi';Sens:'sur';Origin:Grecque),
  (PrefixName:'�pist�mo';Sens:'science';Origin:Grecque),
  (PrefixName:'�pist�m';Sens:'science';Origin:Grecque),
  (PrefixName:'erg';Sens:'action; travail';Origin:Grecque),
  (PrefixName:'ethno';Sens:'peuple';Origin:Grecque),
  (PrefixName:'ethn';Sens:'peuple';Origin:Grecque),
  (PrefixName:'�tho';Sens:'caract�re';Origin:Grecque),
  (PrefixName:'eu';Sens:'bien';Origin:Grecque),
  (PrefixName:'exo';Sens:'au-dehors';Origin:Grecque),
  (PrefixName:'galact';Sens:'lait';Origin:Grecque),
  (PrefixName:'gam';Sens:'mariage';Origin:Grecque),
  (PrefixName:'gastro';Sens:'ventre';Origin:Grecque),
  (PrefixName:'g�o';Sens:'terre';Origin:Grecque),
  (PrefixName:'g�ront';Sens:'vieillard';Origin:Grecque),
  (PrefixName:'gloss';Sens:'langue';Origin:Grecque),
  (PrefixName:'gluc';Sens:'doux, sucr�';Origin:Grecque),
  (PrefixName:'glyc�ro';Sens:'�crire';Origin:Grecque),
  (PrefixName:'glyc';Sens:'�crire';Origin:Grecque),
  (PrefixName:'gyn�co';Sens:'femme';Origin:Grecque),
  (PrefixName:'gyn';Sens:'femme';Origin:Grecque),
  (PrefixName:'gyro';Sens:'cercle';Origin:Grecque),
  (PrefixName:'hapl';Sens:'simple';Origin:Grecque),
  (PrefixName:'hecto';Sens:'cent';Origin:Grecque),
  (PrefixName:'hect';Sens:'cent';Origin:Grecque),
  (PrefixName:'h�lio';Sens:'soleil';Origin:Grecque),
  (PrefixName:'h�li';Sens:'soleil';Origin:Grecque),
  (PrefixName:'h�mato';Sens:'sang';Origin:Grecque),
  (PrefixName:'h�mat';Sens:'sang';Origin:Grecque),
  (PrefixName:'h�mo';Sens:'demi, moiti�';Origin:Grecque),
  (PrefixName:'h�mi';Sens:'demi, moiti�';Origin:Grecque),
  (PrefixName:'h�pato';Sens:'foie';Origin:Grecque),
  (PrefixName:'h�pat';Sens:'foie';Origin:Grecque),
  (PrefixName:'hepta';Sens:'sept';Origin:Grecque),
  (PrefixName:'hept';Sens:'sept';Origin:Grecque),
  (PrefixName:'h�t�ro';Sens:'autre';Origin:Grecque),
  (PrefixName:'hexa';Sens:'six';Origin:Grecque),
  (PrefixName:'hex';Sens:'six';Origin:Grecque),
  (PrefixName:'hi�ro';Sens:'sacr�';Origin:Grecque),
  (PrefixName:'hi�r';Sens:'sacr�';Origin:Grecque),
  (PrefixName:'hippo';Sens:'cheval';Origin:Grecque),
  (PrefixName:'hipp';Sens:'cheval';Origin:Grecque),
  (PrefixName:'hist';Sens:'tissu';Origin:Grecque),
  (PrefixName:'holo';Sens:'entier';Origin:Grecque),
  (PrefixName:'hom�o';Sens:'semblable';Origin:Grecque),
  (PrefixName:'homo';Sens:'heure';Origin:Grecque),
  (PrefixName:'hom';Sens:'heure';Origin:Grecque),
  (PrefixName:'hor';Sens:'heure';Origin:Grecque),
  (PrefixName:'hydr';Sens:'eau';Origin:Grecque),
  (PrefixName:'hygro';Sens:'humide';Origin:Grecque),
  (PrefixName:'hyper';Sens:'sur, au-dessus, exc�s';Origin:Grecque),
  (PrefixName:'hypn';Sens:'sommeil';Origin:Grecque),
  (PrefixName:'hypo';Sens:'sous:insuffissance';Origin:Grecque),
  (PrefixName:'hyst�r';Sens:'ut�rus';Origin:Grecque),
  (PrefixName:'icon';Sens:'image';Origin:Grecque),
  (PrefixName:'id�o';Sens:'id�e';Origin:Grecque),
  (PrefixName:'id�';Sens:'id�e';Origin:Grecque),
  (PrefixName:'idi';Sens:'particulier';Origin:Grecque),
  (PrefixName:'iso';Sens:'�gal';Origin:Grecque),
  (PrefixName:'kilo';Sens:'mille';Origin:Grecque),
  (PrefixName:'laryngo';Sens:'gorge';Origin:Grecque),
  (PrefixName:'laryng';Sens:'gorge';Origin:Grecque),
  (PrefixName:'leuco';Sens:'blanc';Origin:Grecque),
  (PrefixName:'litho';Sens:'pierre';Origin:Grecque),
  (PrefixName:'logo';Sens:'discours, science';Origin:Grecque),
  (PrefixName:'log';Sens:'discours, science';Origin:Grecque),
  (PrefixName:'macro';Sens:'grand';Origin:Grecque),
  (PrefixName:'m�galo';Sens:'grand';Origin:Grecque),
  (PrefixName:'m�ga';Sens:'grand';Origin:Grecque),
  (PrefixName:'m�lo';Sens:'chant';Origin:Grecque),
  (PrefixName:'m�so';Sens:'milieu';Origin:Grecque),
  (PrefixName:'m�s';Sens:'milieu';Origin:Grecque),
  (PrefixName:'m�ta';Sens:'changement, apr�s';Origin:Grecque),
  (PrefixName:'m�tro';Sens:'mesure';Origin:Grecque),
  (PrefixName:'m�tr';Sens:'mesure';Origin:Grecque),
  (PrefixName:'micro';Sens:'petit';Origin:Grecque),
  (PrefixName:'mis';Sens:'haine';Origin:Grecque),
  (PrefixName:'mn�mo';Sens:'m�moire';Origin:Grecque),
  (PrefixName:'mn�m';Sens:'m�moire';Origin:Grecque),
  (PrefixName:'mono';Sens:'seul';Origin:Grecque),
  (PrefixName:'mon';Sens:'seul';Origin:Grecque),
  (PrefixName:'morpho';Sens:'forme';Origin:Grecque),
  (PrefixName:'myco';Sens:'champignons';Origin:Grecque),
  (PrefixName:'my�l';Sens:'moelle';Origin:Grecque),
  (PrefixName:'myo';Sens:'muscle';Origin:Grecque),
  (PrefixName:'myria';Sens:'dix mille';Origin:Grecque),
  (PrefixName:'myri';Sens:'dix mille';Origin:Grecque),
  (PrefixName:'mytho';Sens:'l�gende';Origin:Grecque),
  (PrefixName:'myth';Sens:'l�gende';Origin:Grecque),
  (PrefixName:'my';Sens:'muscle';Origin:Grecque),
  (PrefixName:'n�cro';Sens:'mort';Origin:Grecque),
  (PrefixName:'n�o';Sens:'nouveau';Origin:Grecque),
  (PrefixName:'n�phro';Sens:'rein';Origin:Grecque),
  (PrefixName:'n�phr';Sens:'rein';Origin:Grecque),
  (PrefixName:'neur';Sens:'nerf';Origin:Grecque),
  (PrefixName:'n�vro';Sens:'maladie';Origin:Grecque),
  (PrefixName:'n�vr';Sens:'maladie';Origin:Grecque),
  (PrefixName:'octa';Sens:'huit';Origin:Grecque),
  (PrefixName:'octo';Sens:'huit';Origin:Grecque),
  (PrefixName:'odonto';Sens:'dent';Origin:Grecque),
  (PrefixName:'odont';Sens:'dent';Origin:Grecque),
  (PrefixName:'oniro';Sens:'songe';Origin:Grecque),
  (PrefixName:'onir';Sens:'songe';Origin:Grecque),
  (PrefixName:'ophtalmo';Sens:'oeil';Origin:Grecque),
  (PrefixName:'ophtalm';Sens:'oeil';Origin:Grecque),
  (PrefixName:'ornitho';Sens:'oiseau';Origin:Grecque),
  (PrefixName:'oro';Sens:'montagne';Origin:Grecque),
  (PrefixName:'ortho';Sens:'droit';Origin:Grecque),
  (PrefixName:'ost�o';Sens:'os';Origin:Grecque),
  (PrefixName:'ost�';Sens:'os';Origin:Grecque),
  (PrefixName:'oto';Sens:'oreille';Origin:Grecque),
  (PrefixName:'ot';Sens:'oreille';Origin:Grecque),
  (PrefixName:'oxy';Sens:'aigu, acide';Origin:Grecque),
  (PrefixName:'pachy';Sens:'�pais';Origin:Grecque),
  (PrefixName:'pal�o';Sens:'ancien';Origin:Grecque),
  (PrefixName:'pan';Sens:'tout';Origin:Grecque),
  (PrefixName:'panto';Sens:'voisin de, protection contre';Origin:Grecque),
  (PrefixName:'pant';Sens:'voisin de, protection contre';Origin:Grecque),
  (PrefixName:'para';Sens:'voisin de, protection contre';Origin:Grecque),
  (PrefixName:'par';Sens:'voisin de, protection contre';Origin:Grecque),
  (PrefixName:'patho';Sens:'souffrance';Origin:Grecque),
  (PrefixName:'path';Sens:'souffrance';Origin:Grecque),
  (PrefixName:'p�do';Sens:'enfant';Origin:Grecque),
  (PrefixName:'p�d';Sens:'enfant';Origin:Grecque),
  (PrefixName:'penta';Sens:'cinq';Origin:Grecque),
  (PrefixName:'p�ri';Sens:'autour';Origin:Grecque),
  (PrefixName:'phago';Sens:'manger';Origin:Grecque),
  (PrefixName:'phago';Sens:'manger';Origin:Grecque),
  (PrefixName:'pharmaco';Sens:'m�dicament';Origin:Grecque),
  (PrefixName:'pharmac';Sens:'m�dicament';Origin:Grecque),
  (PrefixName:'pharyngo';Sens:'gosier';Origin:Grecque),
  (PrefixName:'pharyng';Sens:'gosier';Origin:Grecque),
  (PrefixName:'ph�no';Sens:'appara�tre, briller';Origin:Grecque),
  (PrefixName:'ph�n';Sens:'appara�tre, briller';Origin:Grecque),
  (PrefixName:'philo';Sens:'aimer';Origin:Grecque),
  (PrefixName:'phil';Sens:'aimer';Origin:Grecque),
  (PrefixName:'phono';Sens:'voix, son';Origin:Grecque),
  (PrefixName:'phon';Sens:'voix, son';Origin:Grecque),
  (PrefixName:'photo';Sens:'lumi�re';Origin:Grecque),
  (PrefixName:'phyllo';Sens:'feuille';Origin:Grecque),
  (PrefixName:'physio';Sens:'nature';Origin:Grecque),
  (PrefixName:'phys';Sens:'nature';Origin:Grecque),
  (PrefixName:'pleuro';Sens:'c�t�';Origin:Grecque),
  (PrefixName:'plouto';Sens:'richesse';Origin:Grecque),
  (PrefixName:'pneumato';Sens:'poumon';Origin:Grecque),
  (PrefixName:'pneumo';Sens:'pied';Origin:Grecque),
  (PrefixName:'podo';Sens:'pied';Origin:Grecque),
  (PrefixName:'pod';Sens:'pied';Origin:Grecque),
  (PrefixName:'poly';Sens:'nombreux';Origin:Grecque),
  (PrefixName:'pro';Sens:'devant, partisan de, � la place de';Origin:Grecque),
  (PrefixName:'proto';Sens:'premier';Origin:Grecque),
  (PrefixName:'prot';Sens:'premier';Origin:Grecque),
  (PrefixName:'pseudo';Sens:'faux';Origin:Grecque),
  (PrefixName:'pseud';Sens:'faux';Origin:Grecque),
  (PrefixName:'psycho';Sens:'�me';Origin:Grecque),
  (PrefixName:'psych';Sens:'�me';Origin:Grecque),
  (PrefixName:'pt�ro';Sens:'aile';Origin:Grecque),
  (PrefixName:'pyo';Sens:'pus';Origin:Grecque),
  (PrefixName:'pyro';Sens:'feu';Origin:Grecque),
  (PrefixName:'pyr';Sens:'feu';Origin:Grecque),
  (PrefixName:'rh�o';Sens:'couleur';Origin:Grecque),
  (PrefixName:'rhino';Sens:'nez';Origin:Grecque),
  (PrefixName:'rhizo';Sens:'racine';Origin:Grecque),
  (PrefixName:'rhodo';Sens:'rose';Origin:Grecque),
  (PrefixName:'sarco';Sens:'chair';Origin:Grecque),
  (PrefixName:'sauro';Sens:'l�zard';Origin:Grecque),
  (PrefixName:'saur';Sens:'l�zard';Origin:Grecque),
  (PrefixName:'schizo';Sens:'fendre';Origin:Grecque),
  (PrefixName:'s�ma';Sens:'signe';Origin:Grecque),
  (PrefixName:'s�mio';Sens:'signe, signal';Origin:Grecque),
  (PrefixName:'sid�ro';Sens:'fer';Origin:Grecque),
  (PrefixName:'sid�r';Sens:'fer';Origin:Grecque),
  (PrefixName:'sol�no';Sens:'tuyau';Origin:Grecque),
  (PrefixName:'sol�n';Sens:'tuyau';Origin:Grecque),
  (PrefixName:'somato';Sens:'corps';Origin:Grecque),
  (PrefixName:'somat';Sens:'corps';Origin:Grecque),
  (PrefixName:'sp�l�o';Sens:'caverne';Origin:Grecque),
  (PrefixName:'sp�l�';Sens:'caverne';Origin:Grecque),
  (PrefixName:'sph�ro';Sens:'globe';Origin:Grecque),
  (PrefixName:'sph�r';Sens:'globe';Origin:Grecque),
  (PrefixName:'st�r�o';Sens:'solide';Origin:Grecque),
  (PrefixName:'st�r�';Sens:'solide';Origin:Grecque),
  (PrefixName:'stomato';Sens:'bouche';Origin:Grecque),
  (PrefixName:'stomat';Sens:'bouche';Origin:Grecque),
  (PrefixName:'syn';Sens:'avec, ensemble';Origin:Grecque),
  (PrefixName:'sym';Sens:'avec, ensemble';Origin:Grecque),
  (PrefixName:'tachy';Sens:'rapide';Origin:Grecque),
  (PrefixName:'tauto';Sens:'le m�me';Origin:Grecque),
  (PrefixName:'taxi';Sens:'arrangement';Origin:Grecque),
  (PrefixName:'techno';Sens:'art, technique';Origin:Grecque),
  (PrefixName:'t�l�';Sens:'de loin, � distance';Origin:Grecque),
  (PrefixName:'t�tra';Sens:'quatre';Origin:Grecque),
  (PrefixName:'thalasso';Sens:'mer';Origin:Grecque),
  (PrefixName:'th�o';Sens:'dieu';Origin:Grecque),
  (PrefixName:'thermo';Sens:'chaleur';Origin:Grecque),
  (PrefixName:'therm';Sens:'chaleur';Origin:Grecque),
  (PrefixName:'topo';Sens:'lieu';Origin:Grecque),
  (PrefixName:'top';Sens:'lieu';Origin:Grecque),
  (PrefixName:'typo';Sens:'caract�re';Origin:Grecque),
  (PrefixName:'urano';Sens:'ciel';Origin:Grecque),
  (PrefixName:'x�no';Sens:'�tranger';Origin:Grecque),
  (PrefixName:'x�n';Sens:'�tranger';Origin:Grecque),
  (PrefixName:'x�r';Sens:'sec';Origin:Grecque),
  (PrefixName:'xylo';Sens:'bois';Origin:Grecque),
  (PrefixName:'zoo';Sens:'animal';Origin:Grecque),

  (PrefixName:'abs';Sens:'loin de: s�paration';Origin:Latine),
  (PrefixName:'ab';Sens:'loin de: s�paration';Origin:Latine),
  (PrefixName:'ad';Sens:'vers: ajout� �';Origin:Latine),
  (PrefixName:'ambi';Sens:'de part et d''autre';Origin:Latine),
  (PrefixName:'ant�';Sens:'avant; ant�riorit�';Origin:Latine),
  (PrefixName:'bis';Sens:'deux';Origin:Latine),
  (PrefixName:'bi';Sens:'deux';Origin:Latine),
  (PrefixName:'cent';Sens:'centi�me partie';Origin:Latine),
  (PrefixName:'circon';Sens:'autour';Origin:Latine),
  (PrefixName:'circum';Sens:'autour';Origin:Latine),
  (PrefixName:'col';Sens:'avec';Origin:Latine),
  (PrefixName:'com';Sens:'cuivre';Origin:Latine),
  (PrefixName:'con';Sens:'cuivre';Origin:Latine),
  (PrefixName:'cor';Sens:'cuivre';Origin:Latine),
  (PrefixName:'co';Sens:'avec';Origin:Latine),
  (PrefixName:'cupro';Sens:'cuivre';Origin:Latine),
  (PrefixName:'cupr';Sens:'cuivre';Origin:Latine),
  (PrefixName:'d�ci';Sens:'dixi�me partie';Origin:Latine),
  (PrefixName:'d�';Sens:'cessation';Origin:Latine),
  (PrefixName:'dis';Sens:'s�par� de';Origin:Latine),
  (PrefixName:'�qui';Sens:'�gal';Origin:Latine),
  (PrefixName:'extra';Sens:'extr�mement, hors de';Origin:Latine),
  (PrefixName:'ex';Sens:'hors de, qui a cess� d''�tre';Origin:Latine),
  (PrefixName:'il';Sens:'priv� de';Origin:Latine),
  (PrefixName:'im';Sens:'dans, priv� de';Origin:Latine),
  (PrefixName:'inter';Sens:'entre';Origin:Latine),
  (PrefixName:'intra';Sens:'au-dedans';Origin:Latine),
  (PrefixName:'in';Sens:'dans, entre';Origin:Latine),
  (PrefixName:'ir';Sens:'entre';Origin:Latine),
  (PrefixName:'juxta';Sens:'aupr�s de';Origin:Latine),
  (PrefixName:'milli';Sens:'division par mille';Origin:Latine),
  (PrefixName:'mi';Sens:'� moiti�';Origin:Latine),
  (PrefixName:'multi';Sens:'nombreux';Origin:Latine),
  (PrefixName:'octa';Sens:'huit';Origin:Latine),
  (PrefixName:'octo';Sens:'huit';Origin:Latine),
  (PrefixName:'omni';Sens:'tout';Origin:Latine),
  (PrefixName:'p�n�';Sens:'presque';Origin:Latine),
  (PrefixName:'p�n';Sens:'presque';Origin:Latine),
  (PrefixName:'pluri';Sens:'plusieurs';Origin:Latine),
  (PrefixName:'post';Sens:'apr�s : post�riorit�';Origin:Latine),
  (PrefixName:'pr�';Sens:'devant : ant�riorit�';Origin:Latine),
  (PrefixName:'pro';Sens:'en avant';Origin:Latine),
  (PrefixName:'quadri';Sens:'quatre';Origin:Latine),
  (PrefixName:'quadru';Sens:'quatre';Origin:Latine),
  (PrefixName:'quadr';Sens:'quatre';Origin:Latine),
  (PrefixName:'quasi';Sens:'presque';Origin:Latine),
  (PrefixName:'quinqu';Sens:'cinq';Origin:Latine),
  (PrefixName:'radio';Sens:'rayon';Origin:Latine),
  (PrefixName:'r�tro';Sens:'en retour; en arri�re';Origin:Latine),
  (PrefixName:'re';Sens:'de nouveau';Origin:Latine),
  (PrefixName:'r�';Sens:'de nouveau';Origin:Latine),
  (PrefixName:'semi';Sens:'� demi; partiellement';Origin:Latine),
  (PrefixName:'simil';Sens:'semblable';Origin:Latine),
  (PrefixName:'sub';Sens:'sous';Origin:Latine),
  (PrefixName:'super';Sens:'au-dessus';Origin:Latine),
  (PrefixName:'supra';Sens:'au-dessus';Origin:Latine),
  (PrefixName:'sus';Sens:'au-dessus';Origin:Latine),
  (PrefixName:'trans';Sens:'au-del� de; � travers';Origin:Latine),
  (PrefixName:'tri';Sens:'trois';Origin:Latine),
  (PrefixName:'ultra';Sens:'au-del� de';Origin:Latine),
  (PrefixName:'uni';Sens:'un';Origin:Latine),
  (PrefixName:'vice';Sens:'� la place de';Origin:Latine)
 );
Var
 I:Integer;
Begin
 FindPrefix:=False;
 For I:=Low(PrefixList)to High(PrefixList)do Begin
  If(StrToUpper(PrefixList[I].PrefixName)=StrToUpper(Left(Wd,Length(PrefixList[I].PrefixName))))Then Begin
   PrefixName:=PrefixList[I].PrefixName;
   Sens:=PrefixList[I].Sens;
   Case PrefixList[I].Origin of
    Grecque:Origin:='Grecque';
    Latine:Origin:='Latine';
    Francais:Origin:='Fran�aise';
    Else Origin:='';
   End;
   FindPrefix:=True;
   Exit;
  End;
 End;
End;

Function FindSuffix(Wd:String;Var SuffixName,Sens,Origin:String):Boolean;
Type
 SuffixRec=Record
  SuffixName:String[10];
  Sens:String[30];
  Origin:(Grecque,Latine,Francais);
 End;
Const
 SuffixList:Array[0..186]of SuffixRec=(
  (SuffixName:'algie';Sens:'douleur';Origin:Grecque),
  (SuffixName:'archie';Sens:'commandement';Origin:Grecque),
  (SuffixName:'arque';Sens:'commandant';Origin:Grecque),
  (SuffixName:'bare';Sens:'pression';Origin:Grecque),
  (SuffixName:'blaste';Sens:'germe';Origin:Grecque),
  (SuffixName:'bole';Sens:'lan�ant';Origin:Grecque),
  (SuffixName:'carpe';Sens:'fruit';Origin:Grecque),
  (SuffixName:'c�ne';Sens:'r�cent';Origin:Grecque),
  (SuffixName:'c�phale';Sens:'t�te';Origin:Grecque),
  (SuffixName:'coque';Sens:'graine';Origin:Grecque),
  (SuffixName:'cosme';Sens:'monde';Origin:Grecque),
  (SuffixName:'crate';Sens:'pouvoir, force';Origin:Grecque),
  (SuffixName:'cratie';Sens:'pouvoir, force';Origin:Grecque),
  (SuffixName:'cycle';Sens:'roue';Origin:Grecque),
  (SuffixName:'cyte';Sens:'cellule';Origin:Grecque),
  (SuffixName:'crate';Sens:'pouvoir, force';Origin:Grecque),
  (SuffixName:'dactyle';Sens:'ayant des doigts';Origin:Grecque),
  (SuffixName:'doxe';Sens:'opinion';Origin:Grecque),
  (SuffixName:'drome';Sens:'course';Origin:Grecque),
  (SuffixName:'�dre';Sens:'face, base';Origin:Grecque),
  (SuffixName:'�mie';Sens:'sang';Origin:Grecque),
  (SuffixName:'game';Sens:'engendrant';Origin:Grecque),
  (SuffixName:'gamie';Sens:'mariage, union';Origin:Grecque),
  (SuffixName:'g�ne';Sens:'engendrant';Origin:Grecque),
  (SuffixName:'gone';Sens:'angle';Origin:Grecque),
  (SuffixName:'gramme';Sens:'un �crit';Origin:Grecque),
  (SuffixName:'graphe';Sens:'�crivant';Origin:Grecque),
  (SuffixName:'graphie';Sens:'art d''�crire';Origin:Grecque),
  (SuffixName:'gyne';Sens:'femme';Origin:Grecque),
  (SuffixName:'hydre';Sens:'eau';Origin:Grecque),
  (SuffixName:'iatre';Sens:'soignant';Origin:Grecque),
  (SuffixName:'l�trie';Sens:'adoration';Origin:Grecque),
  (SuffixName:'lithe';Sens:'pierre';Origin:Grecque),
  (SuffixName:'lite';Sens:'pierre';Origin:Grecque),
  (SuffixName:'logie';Sens:'science, �tude';Origin:Grecque),
  (SuffixName:'logue';Sens:'�tudiant, sp�cialiste';Origin:Grecque),
  (SuffixName:'mancie';Sens:'divination';Origin:Grecque),
  (SuffixName:'mane';Sens:'ayant la passion, la manie de';Origin:Grecque),
  (SuffixName:'manie';Sens:'passion, obsession';Origin:Grecque),
  (SuffixName:'m�tre';Sens:'mesure';Origin:Grecque),
  (SuffixName:'m�trie';Sens:'pierre';Origin:Grecque),
  (SuffixName:'nome';Sens:'r�glant, loi';Origin:Grecque),
  (SuffixName:'nomie';Sens:'art de mesurer';Origin:Grecque),
  (SuffixName:'o�de';Sens:'ayant la forme';Origin:Grecque),
  (SuffixName:'lithe';Sens:'pierre';Origin:Grecque),
  (SuffixName:'ome';Sens:'maladie, tumeur';Origin:Grecque),
  (SuffixName:'onyme';Sens:'portant le nom';Origin:Grecque),
  (SuffixName:'pathe';Sens:'maladie de';Origin:Grecque),
  (SuffixName:'pathie';Sens:'maladie de';Origin:Grecque),
  (SuffixName:'p�die';Sens:'�ducation';Origin:Grecque),
  (SuffixName:'phage';Sens:'manger';Origin:Grecque),
  (SuffixName:'phagie';Sens:'manger';Origin:Grecque),
  (SuffixName:'phane';Sens:'brillant';Origin:Grecque),
  (SuffixName:'phile';Sens:'aimer';Origin:Grecque),
  (SuffixName:'philie';Sens:'aimer';Origin:Grecque),
  (SuffixName:'phobe';Sens:'craindre';Origin:Grecque),
  (SuffixName:'phobie';Sens:'craindre';Origin:Grecque),
  (SuffixName:'phone';Sens:'voix, son';Origin:Grecque),
  (SuffixName:'phonie';Sens:'voix, son';Origin:Grecque),
  (SuffixName:'phore';Sens:'portant';Origin:Grecque),
  (SuffixName:'phone';Sens:'voix, son';Origin:Grecque),
  (SuffixName:'pith�que';Sens:'singe';Origin:Grecque),
  (SuffixName:'pode';Sens:'pied';Origin:Grecque),
  (SuffixName:'pole';Sens:'ville, vendre';Origin:Grecque),
  (SuffixName:'pt�re';Sens:'aile';Origin:Grecque),
  (SuffixName:'saure';Sens:'l�zard';Origin:Grecque),
  (SuffixName:'scope';Sens:'voir, vision';Origin:Grecque),
  (SuffixName:'scopie';Sens:'voir, vision';Origin:Grecque),
  (SuffixName:'sph�re';Sens:'globe';Origin:Grecque),
  (SuffixName:'taphe';Sens:'tombeau';Origin:Grecque),
  (SuffixName:'technie';Sens:'science, art';Origin:Grecque),
  (SuffixName:'th�que';Sens:'armoire, boite';Origin:Grecque),
  (SuffixName:'th�rapie';Sens:'traitement m�dical';Origin:Grecque),
  (SuffixName:'therme';Sens:'chaleur';Origin:Grecque),
  (SuffixName:'thermie';Sens:'chaleur';Origin:Grecque),
  (SuffixName:'tomie';Sens:'action de couper';Origin:Grecque),
  (SuffixName:'type';Sens:'impression';Origin:Grecque),
  (SuffixName:'typie';Sens:'impression';Origin:Grecque),
  (SuffixName:'urie';Sens:'urine';Origin:Grecque),

  (SuffixName:'cide';Sens:'tuant';Origin:Latine),
  (SuffixName:'cole';Sens:'culture, habitant';Origin:Latine),
  (SuffixName:'culteur';Sens:'cultiver';Origin:Latine),
  (SuffixName:'culture';Sens:'cultiver';Origin:Latine),
  (SuffixName:'f�re';Sens:'portant';Origin:Latine),
  (SuffixName:'fique';Sens:'produisant';Origin:Latine),
  (SuffixName:'forme';Sens:'ayant la forme de';Origin:Latine),
  (SuffixName:'fuge';Sens:'fuir';Origin:Latine),
  (SuffixName:'grade';Sens:'marchant';Origin:Latine),
  (SuffixName:'lingue';Sens:'langue';Origin:Latine),
  (SuffixName:'pare';Sens:'enfantant';Origin:Latine),
  (SuffixName:'p�de';Sens:'pied';Origin:Latine),
  (SuffixName:'vore';Sens:'se nourrissant';Origin:Latine),

  (SuffixName:'ace';Sens:'pr�joratif';Origin:Francais),
  (SuffixName:'asse';Sens:'pr�joratif';Origin:Francais),
  (SuffixName:'ade';Sens:'action, collectif';Origin:Francais),
  (SuffixName:'age';Sens:'action, collectif';Origin:Francais),
  (SuffixName:'aie';Sens:'plantation de v�g�taux';Origin:Francais),
  (SuffixName:'ail';Sens:'instrument';Origin:Francais),
  (SuffixName:'aille';Sens:'action, collectif';Origin:Francais),
  (SuffixName:'ain';Sens:'origine';Origin:Francais),
  (SuffixName:'aine';Sens:'origine, collectif';Origin:Francais),
  (SuffixName:'aire';Sens:'agent';Origin:Francais),
  (SuffixName:'aison';Sens:'action';Origin:Francais),
  (SuffixName:'ion';Sens:'action';Origin:Francais),
  (SuffixName:'ison';Sens:'action';Origin:Francais),
  (SuffixName:'sion';Sens:'action';Origin:Francais),
  (SuffixName:'tion';Sens:'action';Origin:Francais),
  (SuffixName:'ance';Sens:'r�sultat de l''action';Origin:Francais),
  (SuffixName:'ard';Sens:'p�joratif';Origin:Francais),
  (SuffixName:'�tre';Sens:'p�joratif';Origin:Francais),
  (SuffixName:'ature';Sens:'action, instrument';Origin:Francais),
  (SuffixName:'ure';Sens:'action, instrument';Origin:Francais),
  (SuffixName:'aud';Sens:'p�joratif';Origin:Francais),
  (SuffixName:'cule';Sens:'diminutif';Origin:Francais),
  (SuffixName:'ule';Sens:'diminutif';Origin:Francais),
  (SuffixName:'eau';Sens:'diminutif';Origin:Francais),
  (SuffixName:'elle';Sens:'diminutif';Origin:Francais),
  (SuffixName:'ille';Sens:'diminutif';Origin:Francais),
  (SuffixName:'ement';Sens:'action';Origin:Francais),
  (SuffixName:'ment';Sens:'action';Origin:Francais),
  (SuffixName:'ier';Sens:'agent';Origin:Francais),
  (SuffixName:'i�re';Sens:'agent';Origin:Francais),
  (SuffixName:'erie';Sens:'local, qualit�';Origin:Francais),
  (SuffixName:'esse';Sens:'d�faut, qualit�';Origin:Francais),
  (SuffixName:'ette';Sens:'diminutif';Origin:Francais),
  (SuffixName:'et�';Sens:'qualit�';Origin:Francais),
  (SuffixName:'it�';Sens:'qualit�';Origin:Francais),
  (SuffixName:'eur';Sens:'agent';Origin:Francais),
  (SuffixName:'ateur';Sens:'agent';Origin:Francais),
  (SuffixName:'ien';Sens:'profession, origine';Origin:Francais),
  (SuffixName:'ise';Sens:'d�faut, qualit�';Origin:Francais),
  (SuffixName:'isme';Sens:'doctrine, �cole';Origin:Francais),
  (SuffixName:'iste';Sens:'exer�ant un m�tier';Origin:Francais),
  (SuffixName:'ite';Sens:'�tat maladif';Origin:Francais),
  (SuffixName:'itude';Sens:'qualit�';Origin:Francais),
  (SuffixName:'oir';Sens:'instrument';Origin:Francais),
  (SuffixName:'oire';Sens:'instrument';Origin:Francais),
  (SuffixName:'ole';Sens:'diminutif';Origin:Francais),
  (SuffixName:'eron';Sens:'diminutif';Origin:Francais),
  (SuffixName:'illon';Sens:'diminutif';Origin:Francais),
  (SuffixName:'able';Sens:'possibilit�';Origin:Francais),
  (SuffixName:'ible';Sens:'possibilit�';Origin:Francais),
  (SuffixName:'uble';Sens:'possibilit�';Origin:Francais),
  (SuffixName:'ain';Sens:'habitant';Origin:Francais),
  (SuffixName:'ien';Sens:'habitant';Origin:Francais),
  (SuffixName:'ais';Sens:'habitant';Origin:Francais),
  (SuffixName:'ois';Sens:'habitant';Origin:Francais),
  (SuffixName:'ard';Sens:'p�joratif';Origin:Francais),
  (SuffixName:'asse';Sens:'p�joratif';Origin:Francais),
  (SuffixName:'�tre';Sens:'p�joratif';Origin:Francais),
  (SuffixName:'aud';Sens:'p�joratif';Origin:Francais),
  (SuffixName:'esque';Sens:'qualit�';Origin:Francais),
  (SuffixName:'eux';Sens:'d�riv� du nom';Origin:Francais),
  (SuffixName:'ier';Sens:'qualit�';Origin:Francais),
  (SuffixName:'ile';Sens:'qualit�';Origin:Francais),
  (SuffixName:'ique';Sens:'ayant rapport �';Origin:Francais),
  (SuffixName:'iste';Sens:'se rapportant �';Origin:Francais),
  (SuffixName:'ifier';Sens:'rendant, causant';Origin:Francais),
  (SuffixName:'iller';Sens:'diminutif';Origin:Francais),
  (SuffixName:'ailler';Sens:'p�joratif';Origin:Francais),
  (SuffixName:'asser';Sens:'p�joratif';Origin:Francais),
  (SuffixName:'eler';Sens:'d�riv� du nom';Origin:Francais),
  (SuffixName:'iner';Sens:'mouvement r�p�t� et rapide';Origin:Francais),
  (SuffixName:'iser';Sens:'rendant';Origin:Francais),
  (SuffixName:'ocher';Sens:'souvent p�joratif';Origin:Francais),
  (SuffixName:'onner';Sens:'diminutif';Origin:Francais),
  (SuffixName:'oter';Sens:'p�joratif';Origin:Francais),
  (SuffixName:'ouiller';Sens:'diminutif, p�joratif';Origin:Francais),
  (SuffixName:'oyer';Sens:'devenir';Origin:Francais),
  (SuffixName:'al';Sens:'qualit�';Origin:Francais),
  (SuffixName:'an';Sens:'origine';Origin:Francais),
  (SuffixName:'at';Sens:'profession, �tat';Origin:Francais),
  (SuffixName:'�e';Sens:'contenu';Origin:Francais),
  (SuffixName:'el';Sens:'causant';Origin:Francais),
  (SuffixName:'en';Sens:'profession, origine';Origin:Francais),
  (SuffixName:'er';Sens:'agent, d�riv� du nom';Origin:Francais),
  (SuffixName:'et';Sens:'diminutif';Origin:Francais),
  (SuffixName:'ie';Sens:'�tat';Origin:Francais),
  (SuffixName:'if';Sens:'qualit�';Origin:Francais),
  (SuffixName:'in';Sens:'qualit�';Origin:Francais),
  (SuffixName:'ir';Sens:'d�riv� d''adjectif';Origin:Francais),
  (SuffixName:'is';Sens:'r�sultat d''une action';Origin:Francais),
  (SuffixName:'on';Sens:'diminutif';Origin:Francais),
  (SuffixName:'ot';Sens:'diminutif, p�joratif';Origin:Francais),
  (SuffixName:'t�';Sens:'qualit�';Origin:Francais),
  (SuffixName:'�';Sens:'�tat';Origin:Francais),
  (SuffixName:'u';Sens:'qualit�';Origin:Francais)
 );
Var
 I:Integer;
Begin
 FindSuffix:=False;
 For I:=Low(SuffixList)to High(SuffixList)do Begin
  If(StrToUpper(SuffixList[I].SuffixName)=StrToUpper(Right(Wd,Length(SuffixList[I].SuffixName))))Then Begin
   SuffixName:=SuffixList[I].SuffixName;
   Sens:=SuffixList[I].Sens;
   Case SuffixList[I].Origin of
    Grecque:Origin:='Grecque';
    Latine:Origin:='Latine';
    Francais:Origin:='Fran�aise';
    Else Origin:='';
   End;
   FindSuffix:=True;
   Exit;
  End;
 End;
End;

Function NameToTitle(Name:String):TitleType;Begin
 NameToTitle:=Unknown;
 If Left(StrToUpper(Name),3)='DR 'Then NameToTitle:=Docteur Else
 If Left(StrToUpper(Name),4)='DRE 'Then NameToTitle:=Docteure Else
 If Left(StrToUpper(Name),2)='M.'Then NameToTitle:=Monsieur Else
 If Left(StrToUpper(Name),2)='ME 'Then NameToTitle:=Maitre Else
 If Left(StrToUpper(Name),4)='MGR 'Then NameToTitle:=Monseigneur Else
 If Left(StrToUpper(Name),5)='MISS 'Then NameToTitle:=Mademoiselle Else
 If Left(StrToUpper(Name),5)='MISS.'Then NameToTitle:=Mademoiselle Else
 If Left(StrToUpper(Name),5)='MLLE 'Then NameToTitle:=Mademoiselle Else
 If Left(StrToUpper(Name),4)='MME 'Then NameToTitle:=Madame Else
 If Left(StrToUpper(Name),3)='MR 'Then NameToTitle:=Monsieur Else
 If Left(StrToUpper(Name),3)='MR.'Then NameToTitle:=Monsieur Else
 If Left(StrToUpper(Name),3)='MS 'Then NameToTitle:=Madame Else
 If Left(StrToUpper(Name),3)='MS.'Then NameToTitle:=Madame Else
 If Left(StrToUpper(Name),4)='MRS.'Then NameToTitle:=Madame Else
 If Left(StrToUpper(Name),4)='MRS.'Then NameToTitle:=Madame Else
 If Left(StrToUpper(Name),3)='MX 'Then NameToTitle:=NoGender Else
 If Left(StrToUpper(Name),3)='MX.'Then NameToTitle:=NoGender;
End;

END.