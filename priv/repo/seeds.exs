
alias NotABlog.Repo
alias NotABlog.Accounts.User
alias NotABlog.Blog.Post

admin = User.auth_changeset(%User{}, %{name: "Admin", password: "foobar"})

Repo.insert! admin

Repo.insert! %Post{
  title: "Big post",
  content: """
  I'm a big post:

  Albert Einstein's general theory of relativity is one of the towering achievements of 20th-century physics. Published in 1916, it explains that what we perceive as the force of gravity in fact arises from the curvature of space and time.

  Einstein proposed that objects such as the sun and the Earth change this geometry. In the presence of matter and energy it can evolve, stretch and warp, forming ridges, mountains and valleys that cause bodies moving through it to zigzag and curve. So although Earth appears to be pulled towards the sun by gravity, there is no such force. It is simply the geometry of space-time around the sun telling Earth how to move.

  The general theory of relativity has far-reaching consequences. It not only explains the motion of the planets; it can also describe the history and expansion of the universe, the physics of black holes and the bending of light from distant stars and galaxies.
  """
}

Repo.insert! %Post{
  title: "Little post",
  content: "I'm a little post."
}
