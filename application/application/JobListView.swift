import SwiftUI

final class JobListView: UIViewController {
  @ObservedObject var jobListStore: JobListStore
  @ObservedObject var jobConnectionManager: JobConnectionManager
  @State private var showAddJob = false

  init(jobListStore: JobListStore = JobListStore()) {
    self.jobListStore = jobListStore
    jobConnectionManager = JobConnectionManager { job in
      jobListStore.jobs.append(job)
    }
  }
    
    required init(coder: NSCoder) {
        super.init(coder: <#T##NSCoder#>)!
        fatalError("init(coder:) has not been implemented")
    }
    
/*
  var body: some View {
    List {
      Section(
        header: headerView,
        footer: footerView) {
        ForEach(jobListStore.jobs) { job in
          JobListRowView(job: job)
            .environmentObject(jobConnectionManager)
        }
        .onDelete { indexSet in
          jobListStore.jobs.remove(atOffsets: indexSet)
        }
      }
    }
    .listStyle(InsetGroupedListStyle())
    .navigationTitle("Jobs")
    .sheet(isPresented: $showAddJob) {
      NavigationView {
        AddJobView()
          .environmentObject(jobListStore)
      }
    }
  }
*/
  var headerView: some View {
    Toggle("Receive Jobs", isOn: $jobConnectionManager.isReceivingJobs)
  }
/*
  var footerView: some View {
    Button(
      action: {
        showAddJob = true
      }, label: {
        Label("Add Job", systemImage: "plus.circle")
      })
      .buttonStyle(FooterButtonStyle())
  }
 */
}
