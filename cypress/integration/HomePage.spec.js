describe('Landing page', () => {
  it('should contain h1 with Andrew cline', () => {
    cy.visit('/')

    cy.get('h1')
      .should('include.text', 'Andrew Cline')

    cy.get('h3')
      .should('include.text', 'Software Developer')

    cy.get('h3')
      .should('include.text', 'Peoria, IL')
  })
})
