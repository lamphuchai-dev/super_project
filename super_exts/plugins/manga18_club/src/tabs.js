async function tabs() {
  return Response.success([
    {
      title: "Latest Release",
      url: "/latest-release",
    },
    {
      title: "Manga List",
      url: "/list-manga",
    },
  ]);
}
