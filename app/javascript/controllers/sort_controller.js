import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = [ 'column', 'direction', 'form', 'header'];

  applySort(event){
    event.preventDefault();

    const columnToSort = event.target.dataset.column;
    const sortDirection = event.target.dataset.direction;

    this.columnTarget.value = columnToSort;
    this.directionTarget.value = sortDirection;

    const nextSortDirection = (sortDirection == 'asc' ? 'desc' : 'asc');
    event.target.dataset.direction = nextSortDirection;

    this.resetHeaderLabels();

    event.target.innerText = event.target.dataset.label + ` (${sortDirection})`;

    this.formTarget.requestSubmit();
  }

  resetHeaderLabels() {
    this.headerTargets.forEach((header) => {
      header.innerText = header.dataset.label;
    });
  }
}
