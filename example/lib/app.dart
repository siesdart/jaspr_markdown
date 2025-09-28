import 'package:jaspr/jaspr.dart';
import 'package:jaspr_markdown/jaspr_markdown.dart';
import 'package:jaspr_markdown_example/components/custom_card.dart';

class App extends StatelessComponent {
  @override
  Component build(BuildContext context) {
    return Markdown(
      markdown: markdown,
      blockSyntaxes: [
        ComponentBlockSyntax(importComponents: const [CustomCard])
      ],
    );
  }
}

const markdown = '''
# Purpurea et montes

## Mare nec raptusque rumpit

Lorem markdownum paravi bracchia dulci, relicta, ut super revertitur,
consequiturque [suis](http://mille.net/exercita.php), in elige properataque
sacrorum Samius! *Placatoque gnatis flenti* ipsumque: coniunx referebat dabat
puerpera. Lateri dammas plagae medio rigent, nodo magna, tuque latuit gener
Oriens defectos nullam. Dum palmis corvus curarum illis saucius [litore
mihi](http://www.spirarevacuosque.com/) tenuit ipsa dimovit quos; nomen
coniugis, [de in](http://flebile.net/).

Obortis *accipe modo* nunc mariti summo dicentem tamen haec dixit fugit *choro*,
se et qui insignia. Naturale tempora, quod operiri mortale, quaque luctus
ignotae. Manes mox vina in herbis Arcton ruborem vestigia in, in illa ab dedit
poterat sororum gelido. Natum hunc pro mercede fulmina, fidemque colla
lanigerosve arbor, suam volucris media addidici, haec.

[Has tacui](http://www.tuncaevum.com/ab) certatim illic Achilles trium, iterum,
genitoris dici et puteisque poenas dicuntur ore Region mea duro. Inplebo custode
nec ferae minimamque; dei donec ille posse teneat; cadit rerum, vestro est
vobis. Dextraque sine pectore rettulit nec vertice super; poste rapit, sive erat
[finierat praeterque](http://www.tractu.org/lycei-tum).

<CustomCard foo="foo" bar="1" baz="bool">
  <span>baz</span>
</CustomCard>

## Ore dolores imago maius est

Arsisses ex Neretum tractare; venenis veluti silet pia aqua, fuit vincis si iam
certe murmura. **Et arceat Saturnia** in annis ingredior quoniam rogant, cum
decebat pone radicibus me mitto relinquit posses, nigri. Boves repentinos. Aut
fama, haec nomen bella: deus et deceptus decipit lympha formidatis ponite,
accepisse. Suo una saecula versae et quodque tollebat fletus **fervet coeptas**
Aeolidis illa subiecta Aeacidis!

> Nec tenuit, est nare putas cuius omnem lacrimis et arbor Turnusque quoque
> Achilles, adit! Omnia de *montes multis poposcerat* dote, tu acer tamen se
> radicibus, tu nec. Timidasque erat; arva saepe quotiens, et revocare quassaque
> lacrimans ecce lusuque fugit, est tergo domabile. Caelo et videre rupit
> corrigit animus hoc. Ore vestigia iugum, dextera sequens carent parabat **se**
> vidi gravitas.

<CustomCard foo="bar" bar="100" baz/>

## Via muneris

Maxima ut fiducia herba inclusum salutent natura litora, opifer et **iugalia
passu alumni**. Mutua redigar: irae, est fitque animum magna digna loqueretur
contra.

> Erit segetes Persephones [amore](http://nascitanti.net/flores-et), mirabile
> quid. Sperato nil bene, dracones Gorgoneas cessisse **cupido**? Latet latet
> senem me suis erat regni vacuas?

Iamque corpus, arbor mea carminibus sedibus iactabimur Cnosiaco, an. Ora maior
suspicere non quota, at sub Solis virum suum terga. Rubor [quae
humo](http://www.ossa.io/), provolvi ignes flos animam solidis, genitor. Ad
neque ingentia cingentia venit Hippodamen qualis Hymetti subsedit saepe, ecce
qua, tamen caput?

<CustomCard-dotted foo="baz" bar="2">
  <p>qux<span>quux</span></p><small>200</small>
</CustomCard-dotted>
''';
