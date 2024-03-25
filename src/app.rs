use leptos::*;
use leptos_meta::*;
use leptos_router::*;

#[component]
pub fn App() -> impl IntoView {
    // Provides context that manages stylesheets, titles, meta tags, etc.
    provide_meta_context();

    view! {
        <Stylesheet id="leptos" href="/pkg/scripness.css"/>

        // sets the document title
        <Title text="Andrei Scripcaru | Software Engineer"/>

        // content for this welcome page
        <Router>
            <div class="absolute w-screen h-screen bg-[url('/assets/home.jpeg')] bg-center bg-cover bg-no-repeat bg-fixed -z-10">
                <div class="absolute w-screen h-screen bg-black/40"></div>
            </div>

            <main class="rounded bg-black/40 text-white shadow-2xl p-10">
                <Routes>
                    <Route path="" view=HomePage/>
                    <Route path="/*any" view=NotFound/>
                </Routes>
            </main>
        </Router>
    }
}

#[component]
fn HomePage() -> impl IntoView {
    view! {
        <div>
            <h1 class="text-5xl">"Andrei Scripcaru"</h1>
            <h2 class="text-2xl">"Software Engineer"</h2>

            <hr class="my-4"/>

            <div class="gap-y-4 text-xl">
                <p>
                    "When your codebase looks like spaghetti from the '90s, I'm your cleanup crew. Don't fear the mess, let's make it shine!"
                </p>

                <p>
                    "Got a world-changing SaaS idea? Bet you I can make it happen. Let's see if your vision is as awesome as you think it is."
                </p>

                <p>
                    "Harness the power of a 12+ year software development veteran for your web, mobile, and desktop projects."
                </p>

                <p>
                    "My expertise lies in crafting clean code, intuitive user interfaces, and delivering projects that align seamlessly with your business goals."
                </p>

                <p>
                    "Let's" get in touch:
                    <a href="mailto:mail@scripness.com" class="text-bold underline">
                        mail@scripness.com
                    </a>
                </p>
            </div>
        </div>
    }
}

#[component]
fn NotFound() -> impl IntoView {
    // set an HTTP status code 404
    // this is feature gated because it can only be done during
    // initial server-side rendering
    // if you navigate to the 404 page subsequently, the status
    // code will not be set because there is not a new HTTP request
    // to the server
    #[cfg(feature = "ssr")]
    {
        // this can be done inline because it's synchronous
        // if it were async, we'd use a server function
        let resp = expect_context::<leptos_actix::ResponseOptions>();
        resp.set_status(actix_web::http::StatusCode::NOT_FOUND);
    }

    view! { <h1>"Not Found"</h1> }
}
