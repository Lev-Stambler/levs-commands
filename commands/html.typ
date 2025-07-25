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

