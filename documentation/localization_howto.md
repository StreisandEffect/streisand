Localizing Streisand in your language
=====================================

One of the most unique aspects of the Streisand project are the
detailed and customized instructions that it generates for each
of the VPN services it provides. The instructions are hosted
on a password protected website allowing them to be easily shared
among fellow users. This can help in removing ambiguity in how 
certain services need to be set up and can be easily updated as
Streisand evolves.

Scope
-----

The best place to focus localization efforts is on user facing
content, as opposed to developer content.

For example, documentation that can help a user navigate the particularities of certain
cloud providers (account setup, permissions, etc...) are good candidates for localization.

On the other hand, translation of developer oriented texts, such as Ansible 
task names isn't needed at this time.

Language codes
--------------

For simplicity, it is preferable to use 2 character language codes (fr -> French, ar -> Arabic),
as defined by [ISO 631-1](https://en.wikipedia.org/wiki/ISO_639). For certain locales such as
Chinese vs Simplified Chinese, 3 character codes are also acceptable.

Filename conventions
--------------------

In order to differentiate a localized file, append the lowercase language code after the
filename with a 'dash' symbol (e.x. README-fr.md for a README localized in French).

Point of reference
------------------

When translating, English should be considered the point of reference to translate *from*.

READMEs and Documentation
-------------------------

The interaction with Streisand for an end user would be first visiting the project README,
where all the necessary steps one would need to set up their computing environment are
detailed, as well as a listing of all the VPN services provided by Streisand.

Unlike Streisand's instructions markdown template files, READMEs and documentation are
orthogonal to Streisand being able to successfully build. As a consequences, it is possible
to have READMEs and documentation in more languages than Streisand builds documentation with.

Defining locales
----------------

In order to define a locale for Streisand, a new entry defining your language must be
added to the `streisand_languages` dict object in the `playbooks/roles/common/vars/main.yml` file,
where the 2 letter code is considered the key, and a list of key-value pairs with additional data
as its value.

For example:

```
streisand_languages:
  en:
    file_suffix: ""
    language_name: "English"
    tor_locale: "en-US"
  fr:
    file_suffix: "-fr"              # appends to the end of a file name
    language_name: "Français"       # name of the language in the language itself
    tor_locale: "fr"                # edge case for Tor          
```

Localizing gateway instructions
-------------------------------

The following roles contain user instructions that will require translation:

 - `playbooks/roles/openconnect/templates`
  1. `instructions.md.j2`
  1. `mirror.md.j2`

 - `playbooks/roles/openvpn/templates`
  1. `instructions.md.j2`
  1. `stunnel-insructions.md.j2`
  1. `mirror.md.j2`

 - `playbooks/roles/shadowsocks/templates`
  1. `instructions.md.j2`
  1. `mirror.md.j2`

- `playbooks/roles/ssh-forward/templates`
  1. `instructions.md.j2`
  1. `mirror.md.j2`

 - `playbooks/roles/streisand-gateway/templates`
  1. `index.md.j2`
  1. `instructions.md.j2`
  1. `firewall.md.j2`

 - `playbooks/roles/streisand-mirror/templates`
  1. `mirror-index.md.j2`

 - `playbooks/roles/stunnel/templates`
  1. `mirror.md.j2`

 - `playbooks/roles/tor/templates`
  1. `instructions.md.j2`
  1. `mirror.md.j2`

 - `playbooks/roles/wireguard/templates`
  1. `instructions.md.j2`

Language selection in generated pages
-------------------------------------

By default, Streisand's common header file contains language selection links
(generated using the `streisand_languages` dict). For most pages the header with
language selection links will be included automatically. Certain edge cases 
do exist where a jinja2 code block is explicitly needed with the generated html filename.

These edge case files maybe all reside with the `streisand-gateway` role:

 - `firewall.md.j2`
 - `index.md.j2`
 - `instructions.md.j2`

```
- - -
{% for key, value in streisand_languages.items() %}
  [{{ value.language_name }}]({{ streisand_server_name }}-*generated-html-file-name*{{ value.file_suffix }}.html)&nbsp;
{% endfor %}
- - -
```

The HTML filename can be recovered by looking at the relevant Ansible task that generates the
template.

End user considerations
-----------------------

While we aim to have as-close-to-the-original-source translations, linguistic differences in
expressions should be taken into consideration when it makes sense.

A non-technical example would be a the following
expression in English: "the straw that broke the camel's back".
A literal translation into French
would give: "la paille qui a cassé le dos du chameau", however contextually
a similar expression exists in French: "C'est la goutte d'eau qui fait déborder le vase"
(it's the drop of water that made the vase overflow). Different translations,
same meaning. In this case, the latter would be the 'ideal' translation, as it makes more sense
to a native speaker of that language.

Another aspect to consider is what language an end-user's device is set to.
It is best to have a device nearby set in the same language, where you can see exactly what is
displayed in particular menus and use those same exactly what is displayed.

It's worth noting that not all software available in app stores or otherwise are localized
in your language of choice, and many are English only. In this case, it would be sufficient to use
the same English texts, and should you choose, adjacent to it between parenthesis a translation of
the aforementioned text.

In the case where you aren't in possession of a particular device, a best-effort
approach is also acceptable.
