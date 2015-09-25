//= require ../vendor/marked

CodeLab.Lesson = class extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      page: props.page
    }
    this.updatePage = this.updatePage.bind(this)
    this.baseUrl = `/lessons/${props.lesson.key}`
    this.slides = props.lesson.slides.split('\n---\n')
  }

  updatePage(event) {
    event.preventDefault()
    const newPage = event.target.dataset ?
      event.target.dataset.newPage :
      event.target.getAttribute('data-new-page')
    if (newPage < 1 || newPage > this.slides.length) return
    const newURL = `${this.baseUrl}/${newPage}`
    history.pushState({}, null, newURL)
    this.setState({
      page: parseInt(newPage)
    })
  }

  render() {
    return (
      <div>
        <CodeLab.Card>
          <div style={{marginBottom: 15}}>
            <a href='/lessons'>Lessons</a> > <strong>{ this.props.lesson.title }</strong>
          </div>
          { this.slides.length > 1 ?
            <CodeLab.LessonSlidesNavigation
              page = {this.state.page}
              slides = {this.slides}
              baseUrl = {this.baseUrl}
              onUpdatePage = {this.updatePage}
            /> : ''
          }
        </CodeLab.Card>
        <CodeLab.Card style={{
          maxWidth: 600,
          marginTop: -21,
          marginLeft: 'auto',
          marginRight: 'auto',
          padding: '20px 50px 50px',
          borderTop: 0,
          borderBottom: 0,
          borderTopLeftRadius: 0,
          borderTopRightRadius: 0
        }}>
          <CodeLab.LessonSlides slides={this.slides} page={this.state.page}/>
        </CodeLab.Card>
        {
          this.props.user ?
            <CodeLab.Card style={{
              maxWidth: 600,
              marginLeft: 'auto',
              marginRight: 'auto',
              padding: 50
            }}>
              <CodeLab.LessonProject
                lesson = {this.props.lesson}
                authenticityToken = {this.props.authenticityToken}
                user = {this.props.user}
              />
            </CodeLab.Card> : ''
        }

      </div>
    )
  }
}
