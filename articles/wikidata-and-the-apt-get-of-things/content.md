<h2>Wikidata and the apt-get of things</h2>
<img class="cover" src="/assets/img/chess.jpg" alt="Chess and counter-modulation - all  metaphorical interpretation of this picture are fully at your responsibility - CC-BY Maxime Lathuilière 2013">
<p>In my peregrinations on <a href="/articles/p2p-rm">P2P resources management</a> systems, I regularly come back to the idea of an apt-get -like architecture. Now comes <a href="https://www.wikidata.org/">Wikidata</a>, and it gives us a great opportunity to structure it!</p>
<p><em> [9/03/15 note]: I'm currenty prototyping in this direction at <a href="https://inventaire.io">Inventaire.io</a>. That's just a start, there is still a lot to be done to reach something like what is discribed in the present article and I won't go there alone: jump in already!</em></p>

<div class="deeplinking panel">
    <a class="deeplink" href="#apt-get">1 - What is apt-get? (and why it ROCKS!)</a><br>
    <a class="deeplink" href="#inventory-sources">2 - Inventory Sources</a><br>
    <a class="deeplink" href="#wikidata-based-naming-system">3 - A clue on the naming system: wikidata + item patch</a><br>
    <a class="deeplink" href="#ps">Post-Scriptum: Why being stubborn?</a><br>
</div>

<h3><a id="apt-get" href="#apt-get">1 - What is apt-get? (and why it ROCKS!)</a></h3>
<p><a href="https://en.wikipedia.org/wiki/Advanced_Packaging_Tool">apt-get</a> is <a href="https://en.wikipedia.org/wiki/Debian">Debian</a>'s packages manager, that is the piece of software that allows one to install any available software with a snap of the command-lines: entering the command <span class="code">apt-get install firefox</span> will check the <strong>sources</strong> you registered to. If your sources can map your request to a piece of software, here <span class="code">firefox</span>, it will download and install the appropriate software and its dependencies. <br>
In the end, your sources are just a list of domains you trust to provide you with software in exchange of a valid request in debian's namespace.</p>
<p class="code">
# a sample of sources.list for debian <br>
deb http://http.debian.net/debian wheezy main <br>
</p>
<p>
Having the above line in you sources.list means you trust debian.net enough to provide you with software packages.
By default, this sources are the one set by the distribution you installed (Debian, Ubuntu, Mint... <a href="http://blog.websourcing.fr/files/2011/01/evolution-linux-distributions.jpg">make your choice!</a>). The most astonishing thing about this when you come from proprietary operating systems is the ease with which this architecture allows you to update all your softwares at once:</p>
<p class="code">
# make a request to your sources <br>
# to check if anything as changed
<br>
apt-get update
<br>
<br>
# download the packages needed to apply the changes
<br>
apt-get upgrade
</p>
<p class="legend">NB: If you are afraid of the commands, don't be, there are nice graphical user interfaces with shiny rounded angles, but UI/UX isn't in this article's scope.</p>
<p>But if the sources you registered to doesn't know the piece of software you're looking for or doesn't provide the version you want, you can just add new trusted domains following this standard to your source list. This will start to fetch information from this new source, extending the list of softwares known by your system. The best thing in this: <strong>you are not liable to a unique or even a few software providers, it's decentralized!</strong> </p>
<p class="quote"><i class="fa fa-quote-left"></i>Political translation: decentralized = it's less difficult to take control<i class="fa fa-quote-right"></i></p>

<h3><a id="inventory-sources" href="#inventory-sources">2 - Inventory sources</a></h3>
<p>What about doing the same kind of architecture for things/resources - from the things you eat to the books you read - instead of softwares?</p>
<p>Today, when you want to buy a book or a new computer, you probably go to one of the few oligarchic resources management platforms: Amazon, Ebay, Carrefour, Walmart? Their online and offline funnels drives massive streams of customers and, as such, have a predominant control over their attention and buying behaviors (see episodes <a href="/articles/paper-ethical-marketing">one</a> and <a href="/articles/p2p-rm">two</a>).
</p>
<p>But what if we could build resources information platforms in an apt-get way? What if my next search for a shovel wasn't on the website of a given gardening business oligarch but rather on a software/website using the information from the sources I registered to?</p>
<p>
My sources.list could look something like:</p>
<p class="code">
  https://my-neighborhood.org/peers-inventories <br>
  https://my-neighborhood.org/businesses-inventories <br>
  https://my-city.org/peers-inventories <br>
  https://my-city.org/peers-inventories <br>
  https://my-city.org/businesses-inventories <br>
  https://my-favorite-brand.com/inventory <br>
  https://my-favorite-artisan.com/inventory
</p>
<p>
  Nothing revolutionary in this: just as we have RSS source links such as
  <span class="code">http://my-blog.fr/rss</span>
  for blog posts, we could have public links to fetch public resources and links with a privacy mechanism for private resources. And justs as there is hundreds of RSS feed aggregators to match the different needs, we could have a blooming of clients to aggregate those feeds. Mine would allow information crossing with third party sources such as
</p>
<p class="code">
https://greenpeace.org/rankings-elements <br>
https://corporateeurope.org/rankings-elements
</p>
<p>but you do what you want: that's what Free-as-in-Free-speech-softwares are for! It could be hosted <a href="http://unhosted.org/">or not</a>, on your personal cloud or hosted at the NSA, do as you please!
</p>
<p class="quote"><i class="fa fa-quote-left"></i>The point is first to get our information on resources out of businesses' control!<i class="fa fa-quote-right"></i></p>

<h3><a id="wikidata-based-naming-system" href="wikidata-based-naming-system">3 - A clue on the naming system: wikidata + a mapping to non-encyclopedic items</a></h3>
<p>The problem we would encounter then is the one of the naming system in such a decentralized system: decentralization is a nice and brave aim but it's hard and there is <a href="http://www.bortzmeyer.org/no-free-lunch.html">no free lunch</a> <sup class="lang">{fr}</sup>.</p>
<p>
Meanwhile, there's a centralized naming system we can use today to start experimenting: Wikidata!</p>

<p class="quote"><i class="fa fa-quote-left"></i>Do you know how to say <em>Shovel / Schaufel / Pelle / Pala / シャベル / بیل</em> in a worldwide non-ambiguous way?  Wikidata knows: <a href="https://www.wikidata.org/wiki/Q7220961">Q7220961</a>!<i class="fa fa-quote-right"></i></p>

<p>Here is what I dream of:</p>
<p class="code">
inventory update <br>
inventory fetch Q7220961
</p>
<p> This query would provide a list of all the shovels that your trusted sources have knowledge of: the shovel the local retailer sells, the same one that your neigbor propose to buy as second-hand, the one your coworker declared wanting to give away etc. Depending of the client software you use, you might even be reminded of a shovel you bought a few years ago! This identifier might look ugly but user interfaces could easily do the translation to the local labels through the <a href="https://www.wikidata.org/w/api.php?action=wbgetentities&ids=Q7220961&format=json" target="blank">wikidata api</a>.</p>
<p>Of course, various things have to be standardized around this basic naming system: relations and actions for instance. I don't know if the work done at <a href="http://schema.org/Thing">Schema.org</a> can help on that. I would really like to take advantage of all the work on the Linked Open Data, use JSON-LD and stuffs, but I don't see very precisely how it integrates yet: I just know it has all the reasons to connect eventually.
</p>
<img src="/assets/img/miserables.jpg" alt="Les Misérables">
<p class="legend">the object {id: R-000000, isbn: "2211215351", ean: "978-2211225350"} <a href="https://www.wikidata.org/wiki/Property:P31">P31</a>(is an instance of) => <a href="https://www.wikidata.org/wiki/Q180736">Q180736</a> (Les Misérables - V. Hugo) <a href="https://www.wikidata.org/wiki/Property:P31">P31</a>(is an instance of)=> <a href="http://www.wikidata.org/wiki/Q571">Q571</a> (book)</p>
<p>This wikidata-based naming system would also benefit from being extended by a mapping with resources identifiers such as ISBN (books unique identifiers), GTIN (bar codes) etc.: that's what I'm working on and want to progress on in the coming months, and your help is welcome! This could hugely benefit from an acceleration of the OKFN <a href="http://product-open-data.com/">Product-Open-Data</a> project. By the way, Rufus Pollock's "<a href="http://blog.okfn.org/2010/01/05/talk-at-chaos-computer-congress-on-ckan-apt-get-for-the-debian-of-data/">CKAN: apt-get for the Debian of Data</a>" talk was certainly an influence for the approach presented in this article, and CKAN could be an inspiration (if not an advantageously forkable project), but I didn't dig into it enough to see how.
</p>

<h3><a id="ps" href="#ps">Post-Scriptum: Why being stubborn?</a></h3><i class="fa fa-link"></i>
<p>just a memo on why I won't stop before it happens: there is no way I get scammed again buying hair clippers with glued/soldered batteries, dying after only 2 years. That's an information problem and not the kind businesses spontaneously highlight: we need to get structured information on resources out of marketers hand, and thus out of vendors platforms. <em>{insert dramatic music sample here}</em>
<img src="/assets/img/batteries.jpg" alt="planned obsolescence scam">

</p>
<p>
Any feedback welcome!
</p>
