#let defineThmLikeH(name, display-name) = {
  let c = counter(name)

  return (title: none, body) => {
  let env_type = display-name
  //if title != none {
  //  env_type = env_type + " " + title
  //}
  c.step()
  

  // Use a context block to provide different output for HTML and other
  // formats (like PDF).
  context {
    let full-title = [
        *#env_type #c.display()*
        #if title != none {
          [ (#title) ]
        }
      ]
      // For HTML output, we construct the content by concatenating raw HTML
      // snippets with the body content. The `html` function is part of
      // Typst's native HTML support. The `body` content will be
      // automatically converted to HTML by the compiler.
      html.elem("div", attrs: (class: "theorem", style: "display: block; padding: 1em;"))[
        #html.elem("span", attrs: (class: "theorem-title"))[
          #full-title
          //#if title != none {
          //  html.elem("span", attrs: (class: "theorem-title-text"))[(#title)]
          //}
        ]:
        #html.elem("span", attrs: (class: "theorem-body"))[
          #body 
        ]
      ]
    } 
  }
}
}

#let thmH = defineThmLikeH("theorem", "Theorem")
#let axiomH = defineThmLikeH("axiom", "Axiom")
#let definitionH = defineThmLikeH("definition", "Definition")
#let in-no-rules = state("in-no-rules", false)

#let htmlrules(doc) = {
  let incanvas = state("in-cetz-canvas", false)
  let inpad = state("in-pad", false)

  show block: it => context {
    if in-no-rules.get() { it } else {
      html.elem("div", attrs: (style: "display: block;"))[
        #it
      ]
    }
  }

  show grid: it => context {
    if in-no-rules.get() { it } else {
      html.frame(it)
    }
  }

  //show math.equation: it => context {
  //  if incanvas.get() or inpad.get() { it } else { html.frame(it) }
  //}


  show math.equation.where(block: false): it => context {
    if incanvas.get() or inpad.get() or in-no-rules.get() { it } else {
      box(html.frame(it))
    }
  }
  show math.equation.where(block: true): it => context {
    if in-no-rules.get() { it } else [
      #html.elem(
        "div",
        attrs: (
          style: "padding: 0.5em; display: grid; justify-content: center; zoom: 1.3;",
        ),
      )[
        #math.equation(it.body, block: false)
      ]
    ]
  }

  /////////////// Footnote style as tooltip ////////////
  show footnote: it => context {
    if in-no-rules.get() { it } else {
      html.elem("span", attrs: (class: "tooltip-container"))[
        #it
        #html.elem("span", attrs: (class: "tooltip-text"))[
          #it.body
        ]
      ]
    }
  }

  show footnote.entry: it => context {
    if in-no-rules.get() { it } else {
      html.elem("span", attrs: (class: "footnote", title: it.body))[
        #it
      ]
    }
  }

  doc
}

#let frameOriginal = it => context {
  {
    in-no-rules.update(true)
    html.frame(it)
    in-no-rules.update(false)
  }
}


